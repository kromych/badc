
builtin_bit_count.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0xff00ff, (%rsp)       # imm = 0xFF00FF
               	movl	(%rsp), %eax
               	popcntl	%eax, %eax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	movl	$0x3f, %r11d
               	bsrl	%eax, %eax
               	cmovel	%r11d, %eax
               	xorl	$0x1f, %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	movl	$0x20, %r11d
               	bsfl	%eax, %eax
               	cmovel	%r11d, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$0xff00ff, 0x8(%rsp)    # imm = 0xFF00FF
               	movq	0x8(%rsp), %rax
               	popcntq	%rax, %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movl	$0x40, %r11d
               	bsfq	%rax, %rax
               	cmovel	%r11d, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
