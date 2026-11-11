
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
               	retq

<across_index>:
               	movslq	%esi, %rsi
               	movslq	%ecx, %rcx
               	movzbq	(%rdi,%rsi), %rax
               	movb	$0x9, (%rdx,%rcx)
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	retq

<across_equal_index>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movzbq	(%rdi,%rsi), %rax
               	movb	$0xb, (%rdi,%rdx)
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<across_copy>:
               	movslq	%edx, %rdx
               	movzbq	(%rdi,%rdx), %rax
               	movq	(%rsi), %r10
               	movq	%r10, (%rdi)
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rdx), %rcx
               	addq	%rcx, %rax
               	retq

<across_volatile>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	movb	$0x3, (%rdx)
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	retq

<across_word>:
               	movslq	%esi, %rsi
               	movzbq	(%rdi,%rsi), %rax
               	movl	$0x5050505, (%rdx)      # imm = 0x5050505
               	imulq	$0x64, %rax, %rax
               	movzbq	(%rdi,%rsi), %rcx
               	addq	%rcx, %rax
               	retq

<count_zero>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	movsbq	(%rdi,%rax), %rdx
               	leaq	0x1(%rcx), %r8
               	testl	%edx, %edx
               	cmoveq	%r8, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<mark>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	imulq	%rsi, %rax
               	cmpl	%edx, %eax
               	jge	<addr>
               	movb	$0x1, (%rdi,%rax)
               	addq	%rsi, %rax
               	cmpl	%edx, %eax
               	jl	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movb	$-0x80, <rip> # <addr>
               	movb	$0x78, <rip> # <addr>
               	movb	$-0x6f, <rip> # <addr>
               	movb	$-0x77, <rip> # <addr>
               	movb	$-0x5e, <rip> # <addr>
               	movb	$-0x66, <rip> # <addr>
               	movb	$-0x4d, <rip> # <addr>
               	movb	$-0x55, <rip> # <addr>
               	movb	$-0x3c, <rip> # <addr>
               	movb	$-0x44, <rip> # <addr>
               	movb	$-0x2b, <rip> # <addr>
               	movb	$-0x33, <rip> # <addr>
               	movb	$-0x1a, <rip> # <addr>
               	movb	$-0x22, <rip> # <addr>
               	movb	$-0x9, <rip> # <addr>
               	movb	$-0x11, <rip> # <addr>
               	movb	$0x8, <rip> # <addr>
               	movb	$0x0, <rip> # <addr>
               	movb	$0x19, <rip> # <addr>
               	movb	$0x11, <rip> # <addr>
               	movb	$0x2a, <rip> # <addr>
               	movb	$0x22, <rip> # <addr>
               	movb	$0x3b, <rip> # <addr>
               	movb	$0x33, <rip> # <addr>
               	movb	$0x4c, <rip> # <addr>
               	movb	$0x44, <rip> # <addr>
               	movb	$0x5d, <rip> # <addr>
               	movb	$0x55, <rip> # <addr>
               	movb	$0x6e, <rip> # <addr>
               	movb	$0x66, <rip> # <addr>
               	movb	$0x7f, <rip> # <addr>
               	movb	$0x77, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movb	$-0x1, <rip> # <addr>
               	movl	<rip>, %esi # <addr>
               	callq	<addr>
               	cmpl	$-0x80, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x8(%rax), %rsi
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0xf(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %esi # <addr>
               	callq	<addr>
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x8(%rax), %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x7(%rax), %rsi
               	callq	<addr>
               	cmpl	$0xef, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	-0x8(%rax), %rsi
               	callq	<addr>
               	cmpl	$-0x80, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %esi # <addr>
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	0x7(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	-0x1(%rax), %rsi
               	callq	<addr>
               	cmpl	$0xef, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	-0x10(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movslq	<rip>, %rax # <addr>
               	leaq	-0x8(%rax), %rsi
               	callq	<addr>
               	cmpl	$-0x80, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0xf(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x7(%rax), %rsi
               	callq	<addr>
               	cmpl	$0xef, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	-0x1(%rax), %rsi
               	callq	<addr>
               	cmpl	$0xef, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	-0x3(%rax), %rsi
               	movq	$-0x4d, %rdx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x4d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x5(%rax), %rsi
               	callq	<addr>
               	cmpl	$-0x4d, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x5(%rax), %rsi
               	callq	<addr>
               	cmpl	$0xfffed2eb, %eax       # imm = 0xFFFED2EB
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x2(%rax), %rsi
               	movl	$0xc8, %edx
               	callq	<addr>
               	cmpl	$-0x38, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x38, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x2(%rax), %rsi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	cmpl	$0x2c, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	-0x6(%rax), %rsi
               	movq	$-0x81, %rdx
               	callq	<addr>
               	cmpl	$0x7f, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x4(%rdi), %rdx
               	movb	$0x32, (%rdx)
               	movl	<rip>, %eax # <addr>
               	leaq	0x4(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x138f, %eax           # imm = 0x138F
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdx
               	movb	$0x32, (%rdx)
               	leaq	0x8(%rax), %rdi
               	movl	<rip>, %eax # <addr>
               	leaq	-0x4(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x138f, %eax           # imm = 0x138F
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x3c, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x6(%rax), %rsi
               	leaq	0x9(%rdi), %rdx
               	movl	<rip>, %eax # <addr>
               	leaq	-0x3(%rax), %rcx
               	callq	<addr>
               	cmpl	$0x1779, %eax           # imm = 0x1779
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x3c, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x6(%rax), %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	0x5(%rax), %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	cmpl	$0x17ac, %eax           # imm = 0x17AC
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x3c, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x6(%rax), %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	0x6(%rax), %rdx
               	callq	<addr>
               	cmpl	$0x177b, %eax           # imm = 0x177B
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x3c, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x6(%rax), %rsi
               	movl	<rip>, %eax # <addr>
               	leaq	0x7(%rax), %rdx
               	callq	<addr>
               	cmpl	$0x17ac, %eax           # imm = 0x17AC
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	$-0x1, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x6(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x639c, %eax           # imm = 0x639C
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	movl	<rip>, %eax # <addr>
               	leaq	0x3(%rax), %rdx
               	callq	<addr>
               	cmpl	$0x19e, %eax            # imm = 0x19E
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x6(%rdi), %rdx
               	movb	$0x3c, (%rdx)
               	movl	<rip>, %eax # <addr>
               	leaq	0x6(%rax), %rsi
               	callq	<addr>
               	cmpl	$0x1773, %eax           # imm = 0x1773
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movb	$0x3c, -0x7(%rbp)
               	movl	<rip>, %eax # <addr>
               	leaq	0x1(%rax), %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	cmpl	$0x1775, %eax           # imm = 0x1775
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movb	$0x1, <rip> # <addr>
               	movb	$0x1, <rip> # <addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rdi # <addr>
               	cmpb	$0x0, (%rdi,%rbx)
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x40(%rax), %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	incq	%rbx
               	movq	%rbx, %rax
               	imulq	%rbx, %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x12, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %esi # <addr>
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
