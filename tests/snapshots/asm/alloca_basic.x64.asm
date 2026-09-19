
alloca_basic.x64:	file format elf64-x86-64

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

<single>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x20, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	movl	$0x55, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<dynamic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x28, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	imulq	$0x7, %rax, %rsi
               	subq	$0x3, %rsi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movslq	(%rdx,%rax,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<distinct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x10, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r12, %rsp
               	cmpq	%r12, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x41, %esi
               	movl	$0x10, %r13d
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x42, %esi
               	movq	%r12, %rdi
               	movq	%r13, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movsbq	(%rbx), %rax
               	cmpl	$0x41, %eax
               	jne	<addr>
               	movsbq	0xf(%rbx), %rax
               	cmpl	$0x41, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movsbq	(%r12), %rax
               	cmpl	$0x42, %eax
               	jne	<addr>
               	movsbq	0xf(%r12), %rax
               	cmpl	$0x42, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<looped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%edi, %eax
               	jge	<addr>
               	movl	$0x8, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rdx, %rsp
               	movq	%rax, (%rdx)
               	addq	%rax, %rcx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<inner_alloca_disturbs_outer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x33, %esi
               	movl	$0x40, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x14, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rcx
               	cmpl	$0x33, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	cmpl	$0xbe, %edx
               	je	<addr>
               	movq	$-0x2, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x11d, %rax            # imm = 0x11D
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x32, %edi
               	callq	<addr>
               	cmpq	$0x4c9, %rax            # imm = 0x4C9
               	je	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x32, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x33, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
