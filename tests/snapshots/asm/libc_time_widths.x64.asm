
libc_time_widths.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movabsq	$0x12a05f200, %rdi      # imm = 0x12A05F200
               	movl	$0x3b9aca00, %esi       # imm = 0x3B9ACA00
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x41edcd6500000000, %rax # imm = 0x41EDCD6500000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%r12, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x63b0cd00, %rbx       # imm = 0x63B0CD00
               	jge	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	%rbx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	subq	%rbx, %rax
               	cmpq	$0x5, %rax
               	setg	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
