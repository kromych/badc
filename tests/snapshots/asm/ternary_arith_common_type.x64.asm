
ternary_arith_common_type.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edx
               	jmp	<addr>
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %edx
               	jmp	<addr>
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	movl	$0x1, %edx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdx, %rcx
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
