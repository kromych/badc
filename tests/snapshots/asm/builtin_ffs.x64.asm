
builtin_ffs.x64:	file format elf64-x86-64

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
               	movl	$0xff0000, (%rsp)       # imm = 0xFF0000
               	movl	(%rsp), %eax
               	movl	$0x20, %r11d
               	bsfl	%eax, %eax
               	cmovel	%r11d, %eax
               	leaq	0x1(%rax), %rcx
               	shrq	$0x5, %rax
               	decq	%rax
               	andq	%rax, %rcx
               	cmpl	$0x11, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	%eax, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	movl	$0x20, %r11d
               	bsfl	%ecx, %ecx
               	cmovel	%r11d, %ecx
               	leaq	0x1(%rcx), %rdx
               	shrq	$0x5, %rcx
               	decq	%rcx
               	andq	%rcx, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	addq	$0x18, %rsp
               	retq
