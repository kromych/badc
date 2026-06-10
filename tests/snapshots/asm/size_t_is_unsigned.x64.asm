
size_t_is_unsigned.x64:	file format elf64-x86-64

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
               	movabsq	$-0x1, %rax
               	movl	$0x9, %ecx
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %ecx
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movabsq	$0x1c71c71c71c71c71, %r13 # imm = 0x1C71C71C71C71C71
               	cmpq	%r13, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	jae	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %ecx       # imm = 0x80000000
               	movl	$0x5, %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rdx
               	cmpq	%rax, %rcx
               	jae	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movl	%eax, %edx
               	jmp	<addr>
               	movl	%edx, %eax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
