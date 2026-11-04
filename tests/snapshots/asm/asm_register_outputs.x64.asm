
asm_register_outputs.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movl	%ecx, %eax
               	movl	%ecx, %edx
               	shrl	%edx
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	addq	%rcx, %rax
               	cmpq	$0x1b4e81a, %rax        # imm = 0x1B4E81A
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, %cl
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, %ax
               	andq	$0xff, %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	addq	%rcx, %rax
               	cmpl	$0x8a56, %eax           # imm = 0x8A56
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	cmpq	$0x1093, %rax           # imm = 0x1093
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
