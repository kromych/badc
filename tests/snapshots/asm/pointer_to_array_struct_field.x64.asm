
pointer_to_array_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rbx
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%rbx)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	leaq	(%rdx), %rdi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x0, %rdx
               	movslq	%edx, %rsi
               	movw	%si, (%rdi)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	incq	%rdx
               	movslq	%edx, %rdi
               	movw	%di, 0x2(%rsi)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdi
               	movw	%di, 0x4(%rsi)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %rdi
               	movw	%di, 0x6(%rsi)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x4, %rdx
               	movslq	%edx, %rdi
               	movw	%di, 0x8(%rsi)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x5, %rdx
               	movslq	%edx, %rdi
               	movw	%di, 0xa(%rsi)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x6, %rdx
               	movslq	%edx, %rdi
               	movw	%di, 0xc(%rsi)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x7, %rdx
               	movslq	%edx, %rdi
               	movw	%di, 0xe(%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rsi, %r8
               	shlq	$0x4, %r8
               	addq	%r8, %rdx
               	movswq	(%rdx,%rcx,2), %r8
               	imulq	$0x64, %rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %r9
               	movswq	%r9w, %rdx
               	cmpq	%rdx, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rdi
               	movslq	%edi, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movswq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rcx
               	shlq	$0x3, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
