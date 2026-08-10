
anonymous_aggregates.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x1234567890abcdef, %rcx # imm = 0x1234567890ABCDEF
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0x90abcdef, %r11d      # imm = 0x90ABCDEF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xcafebabe, %ecx       # imm = 0xCAFEBABE
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0xbadf00d, %ecx        # imm = 0xBADF00D
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movabsq	$0xbadf00dcafebabe, %r11 # imm = 0xBADF00DCAFEBABE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x5678, %ecx           # imm = 0x5678
               	movw	%cx, 0x6(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x9, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	movl	%eax, %eax
               	cmpq	$0x56781234, %rax       # imm = 0x56781234
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
