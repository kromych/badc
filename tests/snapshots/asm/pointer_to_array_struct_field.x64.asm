
pointer_to_array_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%rax
               	movl	$0x40, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	imulq	$0x64, %rcx, %rsi
               	movw	%si, (%rdx)
               	leaq	0x1(%rsi), %rdi
               	movw	%di, 0x2(%rdx)
               	leaq	0x2(%rsi), %rdi
               	movw	%di, 0x4(%rdx)
               	addq	$0x3, %rsi
               	movw	%si, 0x6(%rdx)
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rax, %rdx
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x4(%rsi), %rdi
               	movw	%di, 0x8(%rdx)
               	leaq	0x5(%rsi), %rdi
               	movw	%di, 0xa(%rdx)
               	leaq	0x6(%rsi), %rdi
               	movw	%di, 0xc(%rdx)
               	addq	$0x7, %rsi
               	movw	%si, 0xe(%rdx)
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%r8d, %r8d
               	movq	%r8, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rax,%rdx), %rsi
               	movswq	(%rsi), %rdi
               	imulq	$0x64, %rcx, %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	movl	$0x1, %r10d
               	movswq	0x2(%rsi), %rdi
               	leaq	0x1(%rdx), %r9
               	nopl	(%rax,%rax)
               	cmpl	%r9d, %edi
               	jne	<addr>
               	movl	$0x2, %r9d
               	movswq	0x4(%rsi), %rsi
               	leaq	0x2(%rdx), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x3, %r10d
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%rax,%rdi), %rsi
               	movswq	0x6(%rsi), %r9
               	addq	$0x3, %rdx
               	cmpl	%edx, %r9d
               	jne	<addr>
               	movl	$0x4, %r11d
               	movswq	0x8(%rsi), %r9
               	imulq	$0x64, %rcx, %rdx
               	leaq	0x4(%rdx), %r10
               	cmpl	%r10d, %r9d
               	jne	<addr>
               	movl	$0x5, %r10d
               	movswq	0xa(%rsi), %rsi
               	leaq	0x5(%rdx), %r9
               	nopl	(%rax)
               	cmpl	%r9d, %esi
               	jne	<addr>
               	movl	$0x6, %r9d
               	leaq	(%rax,%rdi), %rsi
               	movswq	0xc(%rsi), %rsi
               	leaq	0x6(%rdx), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	$0x7, %edi
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movswq	0xe(%rsi), %rsi
               	addq	$0x7, %rdx
               	nopl	(%rax)
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movw	$0xffff, (%rax)         # imm = 0xFFFF
               	movq	%rax, %rdi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movq	%rdi, %r8
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	addq	$0xa, %rax
               	addq	%r8, %rax
               	popq	%r11
               	retq
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r10, %r8
               	jmp	<addr>
               	movq	%r11, %r8
               	jmp	<addr>
               	movq	%r10, %r8
               	jmp	<addr>
               	movq	%r9, %r8
               	jmp	<addr>
               	movq	%r10, %r8
               	jmp	<addr>
