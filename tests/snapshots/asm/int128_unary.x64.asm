
int128_unary.x64:	file format elf64-x86-64

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
               	subq	$0x58, %rsp
               	xorl	%eax, %eax
               	movq	%rax, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	shlq	$0x24, %rcx
               	movq	%rax, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x58, %rsp
               	retq
               	negq	%rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x58, %rsp
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x10(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	cmpq	$0x0, (%rax)
               	movq	0x8(%rax), %rax
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x0, (%rcx)
               	movq	0x8(%rcx), %rcx
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x18(%rsp), %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	leaq	0x30(%rsp), %rax
               	movq	$0x0, 0x30(%rsp)
               	movq	%rdx, 0x38(%rsp)
               	cmpq	$0x0, (%rax)
               	movq	0x8(%rax), %rax
               	jne	<addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	negq	%rdx
               	negq	%rcx
               	movq	%rcx, %rsi
               	sarq	$0x4, %rsi
               	movq	%rdx, %rax
               	shrq	$0x4, %rax
               	movq	%rcx, %rdi
               	shlq	$0x3c, %rdi
               	orq	%rax, %rdi
               	movq	$-0x1, %rax
               	cmpq	%rax, %rdi
               	jne	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x58, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x40(%rsp), %rax
               	movq	$0x0, 0x40(%rsp)
               	movq	$0x0, 0x48(%rsp)
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rcx
               	movq	$0x0, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	(%rsp), %rax
               	jmp	<addr>
               	movl	$0x6, %eax
               	addq	$0x58, %rsp
               	retq
