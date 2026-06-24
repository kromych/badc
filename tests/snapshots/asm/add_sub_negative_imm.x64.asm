
add_sub_negative_imm.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0xa, %eax
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rax, %rdx
               	addq	$-0x5, %rdx
               	movslq	%edx, %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	addq	$-0xa, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	subq	$-0x7, %rdx
               	movslq	%edx, %rdx
               	cmpq	$0x11, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rdx
               	addq	$-0x64, %rdx
               	cmpq	$0x384, %rdx            # imm = 0x384
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	subq	$-0x64, %rcx
               	cmpq	$0x44c, %rcx            # imm = 0x44C
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$-0xfff, %rcx           # imm = 0xF001
               	movslq	%ecx, %rcx
               	cmpq	$-0xff5, %rcx           # imm = 0xF00B
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$-0x1000, %rax          # imm = 0xF000
               	movslq	%eax, %rax
               	cmpq	$-0xff6, %rax           # imm = 0xF00A
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x5, %ecx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	jle	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	decq	%rcx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
