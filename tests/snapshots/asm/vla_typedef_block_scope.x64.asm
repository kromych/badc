
vla_typedef_block_scope.x64:	file format elf64-x86-64

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

<bound_at_declaration>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movq	%rdi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	cmpl	%edi, %edi
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	leaq	0x61(%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	movsbq	(%rcx,%rax), %rax
               	leaq	0x61(%rdi), %rdx
               	decq	%rdx
               	movsbq	%dl, %rdx
               	cmpl	%edx, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	(%rcx,%rdi), %rax
               	subq	%rcx, %rax
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	cmpq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq

<per_iteration>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	movq	%rsp, %r9
               	shrq	$0x2, %rcx
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	movq	%r8, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rsi
               	subq	%r11, %rsi
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rsi, %rsp
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	movl	%ecx, (%rsi,%rcx,4)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	shrq	$0x2, %r8
               	leaq	-0x1(%rdx), %rcx
               	movl	(%rsi,%rcx,4), %ecx
               	addq	%r8, %rcx
               	addq	%rcx, %rax
               	movq	%r9, %rsp
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jle	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x28, %edi
               	callq	<addr>
               	imulq	$0xa, %rax, %rbx
               	testl	%ebx, %ebx
               	jne	<addr>
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x64, %ebx
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
