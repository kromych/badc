
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x20, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	movq	%rbx, %rsp
               	movl	$0x55, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rbx,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	cmpq	$0x55, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x20, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<dynamic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rdx
               	subq	%r11, %rdx
               	movq	%rdx, %rsp
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	imulq	$0x7, %rcx, %rdi
               	subq	$0x3, %rdi
               	movl	%edi, (%rdx,%rcx,4)
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rcx
               	cmpq	%r8, %rcx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	(%rdx,%rsi,4), %rdi
               	addq	%rdi, %rax
               	leaq	0x1(%rsi), %rcx
               	movslq	%ecx, %rsi
               	cmpq	%r8, %rsi
               	jl	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x20(%rbp), %rsp
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<distinct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x10, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	movq	%rbx, %rsp
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	movq	%r12, %rsp
               	cmpq	%r12, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0x60(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
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
               	cmpq	$0x41, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0xf(%rbx), %rax
               	cmpq	$0x41, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x60(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movsbq	(%r12), %rax
               	cmpq	$0x42, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0xf(%r12), %rax
               	cmpq	$0x42, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x60(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x60(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<looped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	$0x8, %esi
               	movq	%rsi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rsi
               	subq	%r11, %rsi
               	movq	%rsi, %rsp
               	movq	%rcx, (%rsi)
               	addq	%rcx, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	movslq	%edx, %rax
               	movslq	%eax, %rax
               	leaq	-0x20(%rbp), %rsp
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<inner_alloca_disturbs_outer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	movl	$0x40, %edx
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	movq	%r12, %rsp
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x14, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%r12,%rcx), %rdx
               	movsbq	(%rdx), %rdx
               	movsbq	%bl, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	movslq	%edi, %rax
               	cmpq	$0xbe, %rax
               	je	<addr>
               	movabsq	$-0x2, %rax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
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
