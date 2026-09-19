
switch_unsigned_negative_case.x64:	file format elf64-x86-64

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

<u32>:
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%rdi, %rax
               	cmpl	%r11d, %edi
               	jb	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rdi, %rax
               	cmpl	%r11d, %edi
               	jb	<addr>
               	movl	$0x64, %eax
               	retq
               	movl	$0xc8, %eax
               	retq
               	cmpl	$0x5, %edi
               	je	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	movl	$0x5, %eax
               	retq

<u16>:
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	retq

<u8>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	cmpq	$-0x1, %rax
               	jb	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq

<s32>:
               	cmpl	$-0x1, %edi
               	jl	<addr>
               	cmpl	$-0x1, %edi
               	je	<addr>
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	retq
               	movl	$0x64, %eax
               	retq
               	cmpl	$-0x2, %edi
               	jne	<addr>
               	movl	$0xc8, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xfffffffe, %edi       # imm = 0xFFFFFFFE
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x3e7, %eax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x3e7, %eax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0xff, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x3e7, %eax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movq	$-0x2, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpl	$0x3e7, %eax            # imm = 0x3E7
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
