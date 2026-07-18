
alloca_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<single>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2030, %rsp           # imm = 0x2030
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x20, %edx
               	movq	%rdx, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x28(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movl	$0x55, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	movslq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x55, %rax
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x20, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	retq
               	jmp	<addr>

<dynamic>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	%edi, 0x10(%rbp)
               	movslq	0x10(%rbp), %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x20(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x8(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rdx
               	movslq	-0x10(%rbp), %rax
               	imulq	$0x7, %rax, %rcx
               	subq	$0x3, %rcx
               	movl	%ecx, (%rdx,%rax,4)
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rdx
               	movq	-0x8(%rbp), %rax
               	movslq	-0x10(%rbp), %rcx
               	movslq	(%rax,%rcx,4), %rax
               	addq	%rdx, %rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<distinct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2050, %rsp           # imm = 0x2050
               	movq	%rbx, (%rsp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x10, %eax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %r11
               	movq	(%r11), %rcx
               	subq	%r10, %rcx
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rcx
               	jae	<addr>
               	ud2
               	movq	%rcx, (%r11)
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x10(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rdi
               	movl	$0x41, %esi
               	movl	$0x10, %ebx
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x10(%rbp), %rdi
               	movl	$0x42, %esi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2038(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movsbq	0xf(%rax), %rax
               	cmpq	$0x41, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2038(%rbp)
               	movq	-0x2038(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x42, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movsbq	0xf(%rax), %rax
               	cmpq	$0x42, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	movq	-0x2040(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq

<looped>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	%edi, 0x10(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x20(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movslq	-0x10(%rbp), %rcx
               	movq	%rcx, (%rax)
               	movslq	-0x8(%rbp), %rcx
               	movq	-0x18(%rbp), %rax
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<inner_alloca_disturbs_outer>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2030, %rsp           # imm = 0x2030
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	%edi, 0x10(%rbp)
               	movl	$0x40, %edx
               	movq	%rdx, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x28(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdi
               	movslq	0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x14, %edi
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	movslq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rax), %rcx
               	movslq	0x10(%rbp), %rax
               	movsbq	%al, %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x40, %rax
               	jl	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0xbe, %rax
               	je	<addr>
               	movabsq	$-0x2, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movabsq	$-0x1, %rax
               	addq	$0x2030, %rsp           # imm = 0x2030
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
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
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x33, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
