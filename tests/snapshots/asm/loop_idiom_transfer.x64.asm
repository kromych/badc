
loop_idiom_transfer.x64:	file format elf64-x86-64

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

<fill_bytes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movl	$0x2, %eax
               	testq	%rsi, %rsi
               	jle	<addr>
               	leaq	(%rsi), %rdx
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

<fill_words>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rsi, %rsi
               	movl	$0x28, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

<copy_arrays>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x28, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

<fill_and_report>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rsi, %rbx
               	movslq	%ebx, %rbx
               	xorq	%rsi, %rsi
               	testq	%rbx, %rbx
               	jle	<addr>
               	movl	$0x1, %esi
               	leaq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rsi
               	movslq	%esi, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x40(%rbp), %rbx
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x10, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	$0x2, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0x10(%rax), %rax
               	cmpq	$0x7f, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r12
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rbx, %rbx
               	movl	$0x2, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rcx
               	jmp	<addr>
               	leaq	(%rcx,%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpq	$0x7f, %rdx
               	jne	<addr>
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rbx
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$-0x3, %rsi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	$0x7f, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rbx
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %eax
               	movb	%al, (%rbx)
               	movb	%al, 0x1(%rbx)
               	movb	%al, 0x2(%rbx)
               	movb	%al, 0x3(%rbx)
               	movb	%al, 0x4(%rbx)
               	movb	%al, 0x5(%rbx)
               	movb	%al, 0x6(%rbx)
               	movb	%al, 0x7(%rbx)
               	movb	%al, 0x8(%rbx)
               	movb	%al, 0x9(%rbx)
               	movb	%al, 0xa(%rbx)
               	movb	%al, 0xb(%rbx)
               	leaq	-0x40(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	$0x3, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0xc, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0xc(%rax), %rax
               	cmpq	$0x7f, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rbx
               	movl	$0x7f, %esi
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x5, %eax
               	movb	%al, 0x4(%rbx)
               	movb	%al, 0x5(%rbx)
               	movb	%al, 0x6(%rbx)
               	movb	%al, 0x7(%rbx)
               	movb	%al, 0x8(%rbx)
               	movb	%al, 0x9(%rbx)
               	movb	%al, 0xa(%rbx)
               	movb	%al, 0xb(%rbx)
               	leaq	-0x40(%rbp), %rcx
               	movsbq	0x3(%rcx), %rax
               	cmpq	$0x7f, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	0x4(%rcx), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	$0x5, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0xc(%rax), %rax
               	cmpq	$0x7f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	leaq	<rip>, %rdi
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movl	%eax, 0x8(%rdi)
               	movl	%eax, 0xc(%rdi)
               	movl	%eax, 0x10(%rdi)
               	movl	%eax, 0x14(%rdi)
               	movl	%eax, 0x18(%rdi)
               	movl	%eax, 0x1c(%rdi)
               	movl	%eax, 0x20(%rdi)
               	movl	%eax, 0x24(%rdi)
               	movl	%eax, 0x28(%rdi)
               	movl	%eax, 0x2c(%rdi)
               	movl	%eax, 0x30(%rdi)
               	movl	%eax, 0x34(%rdi)
               	movl	%eax, 0x38(%rdi)
               	movl	%eax, 0x3c(%rdi)
               	movl	$0xa, %esi
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rdx
               	cmpq	$0xa, %rax
               	jge	<addr>
               	xorq	%rcx, %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rcx
               	jmp	<addr>
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x10, %rax
               	jl	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rdi
               	movb	%dil, (%r8)
               	leaq	<rip>, %rdx
               	addq	%rcx, %rdx
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdi
               	cmpq	$0x28, %rcx
               	jge	<addr>
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %r8
               	movsbq	%r8b, %rdx
               	cmpq	%rdx, %rdi
               	je	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	leaq	-0x40(%rbp), %rbx
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x9, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	$0x1, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x9, %rcx
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rax
               	movsbq	0x9(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movabsq	$-0x1, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
