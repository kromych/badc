
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
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	addq	$0x0, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	$0x0, %rdx
               	movslq	%edx, %rsi
               	movw	%si, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	incq	%rdx
               	movslq	%edx, %rsi
               	movw	%si, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rsi
               	movw	%si, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %rsi
               	movw	%si, 0x6(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	$0x4, %rdx
               	movslq	%edx, %rsi
               	movw	%si, 0x8(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	$0x5, %rdx
               	movslq	%edx, %rsi
               	movw	%si, 0xa(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	$0x6, %rdx
               	movslq	%edx, %rsi
               	movw	%si, 0xc(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rsi, %rax
               	imulq	$0x64, %rdx, %rdx
               	addq	$0x7, %rdx
               	movslq	%edx, %rsi
               	movw	%si, 0xe(%rax)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movslq	%ecx, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	movswq	(%rax,%rdi,2), %rax
               	imulq	$0x64, %rsi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rdi
               	movswq	%di, %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%edx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
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
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
