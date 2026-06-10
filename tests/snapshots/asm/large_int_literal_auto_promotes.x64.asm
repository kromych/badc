
large_int_literal_auto_promotes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movabsq	$0x7fffffffffffffff, %r13 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r13 # imm = 0x8000000000000000
               	movq	%rcx, %rax
               	cmpq	%r13, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x7ffffffffffffffe, %rax # imm = 0x7FFFFFFFFFFFFFFE
               	movabsq	$0x7ffffffffffffffe, %r13 # imm = 0x7FFFFFFFFFFFFFFE
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movabsq	$-0x8000000000000000, %r13 # imm = 0x8000000000000000
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x12a05f201, %rax      # imm = 0x12A05F201
               	movabsq	$0x12a05f201, %r13      # imm = 0x12A05F201
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
