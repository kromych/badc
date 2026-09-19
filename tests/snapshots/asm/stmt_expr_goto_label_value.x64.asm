
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
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	xorl	%edi, %edi
               	movl	$0x64, %esi
               	movabsq	$-0x7fffffffffffffef, %rcx # imm = 0x8000000000000011
               	movq	%rdi, %rax
               	jmp	<addr>
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
               	movq	%rdi, %r8
               	movq	%rdi, %r9
               	cmpl	$0x64, %esi
               	jae	<addr>
               	cmpl	$0xc8, %edi
               	jae	<addr>
               	incq	%r9
               	addq	%rsi, %r8
               	leaq	-0x10(%rbp), %rdx
               	leaq	0x1(%rsi), %rcx
               	movl	$0x64, %esi
               	cmpl	$0x64, %ecx
               	jae	<addr>
               	movq	%rcx, %rax
               	shrq	$0x6, %rax
               	movq	(%rdx,%rax,8), %rbx
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
               	ja	<addr>
               	movq	%rax, %rsi
               	incq	%rdi
               	cmpl	$0x64, %esi
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
               	movl	$0x64, %esi
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
               	cmpl	$0x64, %esi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
