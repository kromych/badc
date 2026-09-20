
pointer_to_array_struct_field.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rax,%rdx), %rsi
               	imulq	$0x64, %rcx, %rdx
               	movw	%dx, (%rsi)
               	leaq	0x1(%rdx), %rdi
               	movw	%di, 0x2(%rsi)
               	leaq	0x2(%rdx), %rdi
               	movw	%di, 0x4(%rsi)
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%rax,%rdi), %rsi
               	addq	$0x3, %rdx
               	movw	%dx, 0x6(%rsi)
               	imulq	$0x64, %rcx, %rdx
               	leaq	0x4(%rdx), %r8
               	movw	%r8w, 0x8(%rsi)
               	leaq	0x5(%rdx), %r8
               	movw	%r8w, 0xa(%rsi)
               	leaq	(%rax,%rdi), %rsi
               	leaq	0x6(%rdx), %rdi
               	movw	%di, 0xc(%rsi)
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	addq	$0x7, %rdx
               	movw	%dx, 0xe(%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%rax,%rsi), %rdi
               	movswq	(%rdi), %r9
               	imulq	$0x64, %rcx, %rdx
               	movswq	%dx, %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movl	$0x1, %ebx
               	movswq	0x2(%rdi), %rdi
               	leaq	0x1(%rdx), %r9
               	movswq	%r9w, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x2, %edi
               	addq	%rax, %rsi
               	movswq	0x4(%rsi), %rsi
               	addq	$0x2, %rdx
               	movswq	%dx, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	movl	$0x3, %r12d
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%rax,%rsi), %rdi
               	movswq	0x6(%rdi), %r9
               	imulq	$0x64, %rcx, %rdx
               	leaq	0x3(%rdx), %rbx
               	movswq	%bx, %rbx
               	cmpl	%ebx, %r9d
               	jne	<addr>
               	movl	$0x4, %ebx
               	movswq	0x8(%rdi), %rdi
               	leaq	0x4(%rdx), %r9
               	movswq	%r9w, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x5, %edi
               	addq	%rax, %rsi
               	movswq	0xa(%rsi), %rsi
               	addq	$0x5, %rdx
               	movswq	%dx, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	movl	$0x6, %ebx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	movswq	0xc(%rdx), %rdi
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x6(%rsi), %r9
               	movswq	%r9w, %r9
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x7, %edi
               	movswq	0xe(%rdx), %rdx
               	addq	$0x7, %rsi
               	movswq	%si, %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movw	$0xffff, (%rax)         # imm = 0xFFFF
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rdi, %r8
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	$0xa, %rax
               	addq	%r8, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %r8
               	jmp	<addr>
               	movq	%rdi, %r8
               	jmp	<addr>
               	movq	%rbx, %r8
               	jmp	<addr>
               	movq	%r12, %r8
               	jmp	<addr>
               	movq	%rdi, %r8
               	jmp	<addr>
               	movq	%rbx, %r8
               	jmp	<addr>
