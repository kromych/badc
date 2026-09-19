
byte_index_addressing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<get_s>:
               	movslq	%esi, %rsi
               	movsbq	(%rdi,%rsi), %rax
               	retq

<get_u>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	retq

<get_long>:
               	movsbq	(%rdi,%rsi), %rax
               	retq

<get_unsigned>:
               	movl	%esi, %eax
               	movzbq	(%rdi,%rax), %rax
               	retq

<get_reversed>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	retq

<put>:
               	movslq	%esi, %rsi
               	movb	$-0x4d, (%rdi,%rsi)
               	retq

<twice_s>:
               	movslq	%esi, %rsi
               	movsbq	(%rdi,%rsi), %rax
               	imulq	$0x3e8, %rax, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<stored_s>:
               	movslq	%esi, %rsi
               	movb	%dl, (%rdi,%rsi)
               	movsbq	%dl, %rax
               	retq

<stored_u>:
               	movslq	%esi, %rsi
               	movb	$0x2c, (%rdi,%rsi)
               	movzbq	(%rdi,%rsi), %rax
               	retq

<across_pointer>:
               	movslq	%esi, %rsi
               	movsbq	(%rdi,%rsi), %rax
               	movb	$0x7, (%rdx)
               	imulq	$0x64, %rax, %rax
               	movsbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<across_index>:
               	movslq	%esi, %rsi
               	movslq	%ecx, %rcx
               	movzbq	(%rdi,%rsi), %rax
               	movb	$0x9, (%rdx,%rcx)
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<across_equal_index>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movzbq	(%rdi,%rsi), %rax
               	movb	$0xb, (%rdi,%rdx)
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<bump>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	incq	%rax
               	movb	%al, (%rdi,%rsi)
               	retq

<across_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movzbq	(%rbx,%r12), %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	imulq	$0x64, %r13, %rax
               	movzbq	(%rbx,%r12), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<across_copy>:
               	movslq	%edx, %rdx
               	movzbq	(%rdi,%rdx), %rax
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	popq	%rax
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rdx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<across_volatile>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	movb	$0x3, (%rdx)
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<across_word>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	movl	$0x5050505, (%rdx)      # imm = 0x5050505
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<count_zero>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	cmpb	$0x0, (%rdi,%rax)
               	jne	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<mark>:
               	movq	%rsi, %rax
               	imulq	%rsi, %rax
               	cmpl	%edx, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movb	$0x1, (%rdi,%rcx)
               	addq	%rsi, %rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movb	$-0x80, (%rax)
               	leaq	<rip>, %rcx
               	movb	$0x78, (%rcx)
               	movb	$-0x6f, 0x1(%rax)
               	movb	$-0x77, 0x1(%rcx)
               	movb	$-0x5e, 0x2(%rax)
               	movb	$-0x66, 0x2(%rcx)
               	movb	$-0x4d, 0x3(%rax)
               	movb	$-0x55, 0x3(%rcx)
               	leaq	<rip>, %rax
               	movb	$-0x3c, 0x4(%rax)
               	leaq	<rip>, %rcx
               	movb	$-0x44, 0x4(%rcx)
               	movb	$-0x2b, 0x5(%rax)
               	movb	$-0x33, 0x5(%rcx)
               	movb	$-0x1a, 0x6(%rax)
               	movb	$-0x22, 0x6(%rcx)
               	movb	$-0x9, 0x7(%rax)
               	movb	$-0x11, 0x7(%rcx)
               	leaq	<rip>, %rax
               	movb	$0x8, 0x8(%rax)
               	leaq	<rip>, %rcx
               	movb	$0x0, 0x8(%rcx)
               	movb	$0x19, 0x9(%rax)
               	movb	$0x11, 0x9(%rcx)
               	movb	$0x2a, 0xa(%rax)
               	movb	$0x22, 0xa(%rcx)
               	movb	$0x3b, 0xb(%rax)
               	movb	$0x33, 0xb(%rcx)
               	leaq	<rip>, %rax
               	movb	$0x4c, 0xc(%rax)
               	leaq	<rip>, %rcx
               	movb	$0x44, 0xc(%rcx)
               	movb	$0x5d, 0xd(%rax)
               	movb	$0x55, 0xd(%rcx)
               	movb	$0x6e, 0xe(%rax)
               	movb	$0x66, 0xe(%rcx)
               	movb	$0x7f, 0xf(%rax)
               	movb	$0x77, 0xf(%rcx)
               	leaq	<rip>, %rdi
               	movb	$-0x1, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x8(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0xf(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x78, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x8(%rax), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x7(%rax), %rsi
               	callq	<addr>
               	cmpq	$0xef, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x8(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x7(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x1(%rax), %rsi
               	callq	<addr>
               	cmpq	$0xef, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x10(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x78, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x8(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0xf(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x7, %rax
               	movl	%eax, %esi
               	callq	<addr>
               	cmpq	$0xef, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x1(%rax), %rsi
               	callq	<addr>
               	cmpq	$0xef, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	leaq	0x8(%rbx), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x3(%rax), %rsi
               	movq	$-0x4d, %rdx
               	callq	<addr>
               	movsbq	0x5(%rbx), %rax
               	cmpl	$-0x4d, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x5(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x4d, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x5(%rax), %rsi
               	callq	<addr>
               	cmpq	$-0x12d15, %rax         # imm = 0xFFFED2EB
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x2(%rax), %rsi
               	movl	$0xc8, %edx
               	callq	<addr>
               	cmpq	$-0x38, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x2(%rax), %rax
               	cmpl	$-0x38, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x2(%rax), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x2(%rax), %rax
               	xorq	$0x2c, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x6(%rax), %rsi
               	movq	$-0x81, %rdx
               	callq	<addr>
               	cmpq	$0x7f, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movsbq	0x2(%rdi), %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x4(%rdi), %rdx
               	movb	$0x32, (%rdx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x4(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x138f, %rax           # imm = 0x138F
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	0x4(%rax), %rdx
               	movb	$0x32, (%rdx)
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x4(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x138f, %rax           # imm = 0x138F
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x3c, 0x6(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x6(%rcx), %rsi
               	leaq	0x9(%rdi), %rdx
               	movslq	(%rax), %rax
               	leaq	-0x3(%rax), %rcx
               	callq	<addr>
               	cmpq	$0x1779, %rax           # imm = 0x1779
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x3c, 0x6(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x6(%rcx), %rsi
               	movslq	(%rax), %rax
               	leaq	0x5(%rax), %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	cmpq	$0x17ac, %rax           # imm = 0x17AC
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x3c, 0x6(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x6(%rcx), %rsi
               	movslq	(%rax), %rax
               	leaq	0x6(%rax), %rdx
               	callq	<addr>
               	cmpq	$0x177b, %rax           # imm = 0x177B
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x3c, 0x6(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x6(%rcx), %rsi
               	movslq	(%rax), %rax
               	leaq	0x7(%rax), %rdx
               	callq	<addr>
               	cmpq	$0x17ac, %rax           # imm = 0x17AC
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$-0x1, 0x6(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x6(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x639c, %rax           # imm = 0x639C
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x3(%rax), %rdx
               	callq	<addr>
               	cmpq	$0x19e, %rax            # imm = 0x19E
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	0x6(%rdi), %rdx
               	movb	$0x3c, (%rdx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x6(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x1773, %rax           # imm = 0x1773
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movb	$0x3c, 0x1(%rdi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x1(%rax), %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	cmpq	$0x1775, %rax           # imm = 0x1775
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movb	$0x1, (%rax)
               	movb	$0x1, 0x1(%rax)
               	movl	$0x2, %ebx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rax
               	cmpb	$0x0, (%rdi,%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x40(%rax), %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	incq	%rbx
               	movq	%rbx, %rax
               	imulq	%rbx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
