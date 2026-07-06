
integer_negate_shift_overflow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	imulq	$-0x1, %rax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	imulq	$-0x1, %rax, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movslq	%eax, %rax
               	sarq	$0x10, %rax
               	cmpq	$-0x8000, %rax          # imm = 0x8000
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	imulq	$-0x1, %rax, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	$0x1, %eax
               	imulq	$-0x1, %rax, %rax
               	movl	%eax, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
