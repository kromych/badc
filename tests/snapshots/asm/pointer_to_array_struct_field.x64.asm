
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	leaq	(%rdx), %r8
               	imulq	$0x64, %rax, %rdx
               	addq	$0x0, %rdx
               	movslq	%edx, %rsi
               	movw	%si, (%r8)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	incq	%rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0x2(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0x4(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0x6(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x4, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0x8(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x5, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0xa(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x6, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0xc(%rsi)
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rdi,%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x7, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0xe(%rsi)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movswq	(%rdx,%rcx,2), %r9
               	imulq	$0x64, %rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rbx
               	movswq	%bx, %rdx
               	cmpq	%rdx, %r9
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %r8
               	movslq	%r8d, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	movabsq	$-0x1, %rax
               	movw	%ax, (%rdi)
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r8, %rcx
               	shlq	$0x3, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
