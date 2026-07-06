
integer_literal_suffix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x24, %eax
               	movl	$0x1, %ecx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	decq	%rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movabsq	$0x123456789, %rax      # imm = 0x123456789
               	incq	%rax
               	movabsq	$0x12345678a, %r11      # imm = 0x12345678A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movabsq	$-0x1, %rax
               	incq	%rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
