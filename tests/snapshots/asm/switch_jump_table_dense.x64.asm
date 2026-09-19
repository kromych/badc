
switch_jump_table_dense.x64:	file format elf64-x86-64

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
               	movl	$0x3, %ecx
               	cmpl	$0x13, %ecx
               	jg	<addr>
               	cmpl	$0xf, %ecx
               	je	<addr>
               	cmpl	$0xf, %ecx
               	jge	<addr>
               	leaq	-0x2(%rcx), %rdx
               	leaq	-0x3(%rcx), %rax
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x1, %eax
               	cmpl	%edx, %eax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movq	$-0x1, %rax
               	jmp	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	leaq	-0x3(%rcx), %rdx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x13, %ecx
               	jle	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	retq
