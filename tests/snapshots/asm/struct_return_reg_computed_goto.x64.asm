
struct_return_reg_computed_goto.x64:	file format elf64-x86-64

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

<simple>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	leaq	<rip>, %rcx         # <addr>
               	jmpq	*%rcx
               	movl	$0x7, %ecx
               	movl	%ecx, -0x18(%rbp)
               	movslq	%ecx, %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<ternary>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, 0x10(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	movslq	%edi, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rcx
               	jmpq	*%rcx
               	movl	$0x1, %eax
               	movl	%eax, -0x18(%rbp)
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x2, %ecx
               	movl	%ecx, -0x18(%rbp)
               	movslq	%ecx, %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movq	%rax, -0x18(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
