
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
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	(%rcx,%r8), %rsi
               	leaq	(%rsi), %r9
               	imulq	$0x64, %rax, %rdx
               	leaq	(%rdx), %rdi
               	movw	%di, (%r9)
               	leaq	0x1(%rdx), %rdi
               	movw	%di, 0x2(%rsi)
               	leaq	0x2(%rdx), %rdi
               	movw	%di, 0x4(%rsi)
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	(%rcx,%r8), %rsi
               	addq	$0x3, %rdx
               	movw	%dx, 0x6(%rsi)
               	imulq	$0x64, %rax, %rdx
               	leaq	0x4(%rdx), %rdi
               	movw	%di, 0x8(%rsi)
               	leaq	0x5(%rdx), %rdi
               	movw	%di, 0xa(%rsi)
               	leaq	(%rcx,%r8), %rdi
               	leaq	0x6(%rdx), %rsi
               	movw	%si, 0xc(%rdi)
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rcx, %rsi
               	addq	$0x7, %rdx
               	movw	%dx, 0xe(%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%r9d, %r9d
               	movq	%r9, %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%rcx,%rdi), %r8
               	leaq	(%r8), %rdx
               	movswq	(%rdx), %rbx
               	imulq	$0x64, %rax, %rdx
               	leaq	(%rdx), %rsi
               	movswq	%si, %rsi
               	cmpl	%esi, %ebx
               	jne	<addr>
               	movl	$0x1, %ebx
               	movswq	0x2(%r8), %r8
               	leaq	0x1(%rdx), %rsi
               	movswq	%si, %rsi
               	cmpl	%esi, %r8d
               	jne	<addr>
               	movl	$0x2, %r8d
               	leaq	(%rcx,%rdi), %rsi
               	movswq	0x4(%rsi), %rsi
               	addq	$0x2, %rdx
               	movswq	%dx, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	movl	$0x3, %r12d
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	(%rcx,%r8), %rsi
               	movswq	0x6(%rsi), %rbx
               	imulq	$0x64, %rax, %rdx
               	leaq	0x3(%rdx), %rdi
               	movswq	%di, %rdi
               	cmpl	%edi, %ebx
               	jne	<addr>
               	movl	$0x4, %ebx
               	movswq	0x8(%rsi), %rdi
               	leaq	0x4(%rdx), %rsi
               	movswq	%si, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x5, %edi
               	leaq	(%rcx,%r8), %rsi
               	movswq	0xa(%rsi), %rsi
               	addq	$0x5, %rdx
               	movswq	%dx, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	movl	$0x6, %r12d
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	(%rcx,%r8), %rsi
               	movswq	0xc(%rsi), %rbx
               	imulq	$0x64, %rax, %rdx
               	leaq	0x6(%rdx), %rdi
               	movswq	%di, %rdi
               	cmpl	%edi, %ebx
               	jne	<addr>
               	movl	$0x7, %edi
               	movswq	0xe(%rsi), %rsi
               	addq	$0x7, %rdx
               	movswq	%dx, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	$-0x1, %rax
               	movw	%ax, (%rcx)
               	movq	%rcx, %rdi
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
               	movq	%rdi, %r9
               	shlq	$0x3, %rax
               	addq	$0xa, %rax
               	addq	%r9, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%r12, %r9
               	jmp	<addr>
               	movq	%rdi, %r9
               	jmp	<addr>
               	movq	%rbx, %r9
               	jmp	<addr>
               	movq	%r12, %r9
               	jmp	<addr>
               	movq	%r8, %r9
               	jmp	<addr>
               	movq	%rbx, %r9
               	jmp	<addr>
