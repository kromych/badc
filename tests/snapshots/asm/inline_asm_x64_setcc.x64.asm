
inline_asm_x64_setcc.x64:	file format elf64-x86-64

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
               	movl	$0x5, %r10d
               	movl	$0x5, %r11d
               	cmpq	%r11, %r10
               	sete	%al
               	andq	$0xff, %rax
               	imulq	$0x14, %rax, %rcx
               	movl	$0x3, %r10d
               	movl	$0x7, %r11d
               	cmpq	%r11, %r10
               	setl	%al
               	andq	$0xff, %rax
               	imulq	$0xf, %rax, %rax
               	addq	%rax, %rcx
               	movl	$0x9, %r10d
               	movl	$0x4, %r11d
               	cmpq	%r11, %r10
               	setg	%al
               	andq	$0xff, %rax
               	imulq	$0x7, %rax, %rax
               	addq	%rax, %rcx
               	movl	$0x1, %r10d
               	movl	$0x2, %r11d
               	cmpq	%r11, %r10
               	sete	%al
               	andq	$0xff, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %rcx
               	movl	$0x9, %r10d
               	movl	$0x3, %r11d
               	cmpq	%r11, %r10
               	setl	%al
               	andq	$0xff, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %rcx
               	movl	$0x4, %r10d
               	movl	$0x9, %r11d
               	cmpq	%r11, %r10
               	setg	%al
               	andq	$0xff, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	retq
