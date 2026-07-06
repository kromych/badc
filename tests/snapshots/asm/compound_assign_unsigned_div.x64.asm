
compound_assign_unsigned_div.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %ecx       # imm = 0xFFFFFFFE
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	popq	%rdx
               	movl	%eax, %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %ecx       # imm = 0xFFFFFFFE
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	movl	%eax, %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$-0x2, %rax
               	movl	$0x2, %ecx
               	movl	%eax, %eax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	popq	%rdx
               	movslq	%eax, %rax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$-0x7, %rax
               	movl	$0x3, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x3, %ecx
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	popq	%rdx
               	movabsq	$0x5555555555555555, %r11 # imm = 0x5555555555555555
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0xff, %eax
               	movabsq	$-0x2, %rcx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	andq	$0xff, %rax
               	xorq	$0x81, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
