
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
               	addq	$0x0, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x0, %rsi
               	movslq	%esi, %rdi
               	movw	%di, (%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	incq	%rsi
               	movslq	%esi, %rdi
               	movw	%di, 0x2(%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x2, %rsi
               	movslq	%esi, %rdi
               	movw	%di, 0x4(%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x3, %rsi
               	movslq	%esi, %rdi
               	movw	%di, 0x6(%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x4, %rsi
               	movslq	%esi, %rdi
               	movw	%di, 0x8(%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x5, %rsi
               	movslq	%esi, %rdi
               	movw	%di, 0xa(%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x6, %rsi
               	movslq	%esi, %rdi
               	movw	%di, 0xc(%rdx)
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x7, %rsi
               	movslq	%esi, %rdi
               	movw	%di, 0xe(%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %rdi
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	addq	%r8, %rdi
               	movswq	(%rdi,%rdx,2), %rdi
               	imulq	$0x64, %rax, %r8
               	addq	%rdx, %r8
               	movslq	%r8d, %r9
               	movswq	%r9w, %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x8, %rdx
               	jl	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
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
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	$0xa, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
