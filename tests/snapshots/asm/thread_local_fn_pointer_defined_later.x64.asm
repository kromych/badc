
thread_local_fn_pointer_defined_later.x64:	file format elf64-x86-64

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

<fb>:
               	movl	$0x32, %eax
               	retq

<f0>:
               	movl	$0x64, %eax
               	retq

<f1_ext>:
               	movl	$0xc8, %eax
               	retq

<f2>:
               	movl	$0x12c, %eax            # imm = 0x12C
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x48, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0x64, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x40, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0xc8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x38, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x38, %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	cmpq	$0x64, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x28, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x28, %rax
               	movq	0x8(%rax), %rax
               	callq	*%rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	movq	(%rcx), %rcx
               	leaq	-<rip>, %rdx      # <addr>
               	subq	%rdx, %rcx
               	cmpq	$0x4, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	movq	0x8(%rcx), %rcx
               	leaq	-<rip>, %rdx      # <addr>
               	subq	%rdx, %rcx
               	cmpq	$0x8, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movq	0x10(%rax), %rax
               	leaq	-<rip>, %rcx      # <addr>
               	subq	%rcx, %rax
               	cmpq	$-0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
