
switch_const_index_jump_table_fold.x64:	file format elf64-x86-64

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
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x14, %eax
               	cmpl	$0x19, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x14, %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x14, %eax
               	cmpl	$0x1b, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x9, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rax,8), %r10
               	jmpq	*%r10
               	movl	$0x14, %eax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x15, %eax
               	jmp	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movq	$-0x2, %rax
               	jmp	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movq	$-0x2, %rax
               	jmp	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movq	$-0x2, %rax
               	jmp	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movl	$0x17, %eax
               	jmp	<addr>
               	movl	$0x18, %eax
               	jmp	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movq	$-0x2, %rax
               	jmp	<addr>
