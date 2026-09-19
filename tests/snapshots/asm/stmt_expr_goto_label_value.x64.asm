
stmt_expr_goto_label_value.x64:	file format elf64-x86-64

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
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorl	%edx, %edx
               	movq	%rdx, %rdi
               	movq	%rdx, %r9
               	movq	%rdx, %r8
               	cmpl	$0xc8, %edi
               	jae	<addr>
               	incq	%r9
               	addq	%rdx, %r8
               	leaq	-0x10(%rbp), %rsi
               	leaq	0x1(%rdx), %rcx
               	movl	$0x64, %edx
               	cmpl	$0x64, %ecx
               	jae	<addr>
               	movq	%rcx, %rax
               	shrq	$0x6, %rax
               	movq	(%rsi,%rax,8), %rbx
               	movq	$-0x1, %r12
               	andq	$0x3f, %rcx
               	movq	%rcx, %r10
               	movq	%r12, %r11
               	movq	%r10, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	andq	%rbx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, %rcx
               	shlq	$0x6, %rcx
               	cmpq	$0x64, %rcx
               	jae	<addr>
               	movq	(%rsi,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rsi
               	shlq	$0x6, %rsi
               	leaq	-0x1(%rcx), %rax
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	%rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	addq	%rsi, %rax
               	cmpq	$0x64, %rax
               	ja	<addr>
               	movq	%rax, %rdx
               	incq	%rdi
               	cmpl	$0x64, %edx
               	jb	<addr>
               	cmpq	$0x5, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	cmpq	$0xcb, %r8
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	incq	%rax
               	movq	%rax, %rcx
               	shlq	$0x6, %rcx
               	cmpq	$0x64, %rcx
               	jae	<addr>
               	movq	(%rdx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rdx
               	shlq	$0x6, %rdx
               	leaq	-0x1(%rcx), %rax
               	xorq	$-0x1, %rcx
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	%rcx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	andq	%r11, %rcx
               	subq	%rcx, %rax
               	movabsq	$0x3333333333333333, %rcx # imm = 0x3333333333333333
               	andq	%rax, %rcx
               	shrq	$0x2, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	andq	%r11, %rax
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	addq	%rcx, %rax
               	movabsq	$0xf0f0f0f0f0f0f0f, %r11 # imm = 0xF0F0F0F0F0F0F0F
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	shrq	$0x8, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x10, %rcx
               	addq	%rcx, %rax
               	movq	%rax, %rcx
               	shrq	$0x20, %rcx
               	addq	%rcx, %rax
               	andq	$0x7f, %rax
               	addq	%rdx, %rax
               	cmpq	$0x64, %rax
               	jbe	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
