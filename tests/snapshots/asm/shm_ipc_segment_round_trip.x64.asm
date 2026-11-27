
shm_ipc_segment_round_trip.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x98, %rsp
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x380, %edx            # imm = 0x380
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, 0x18(%rsp)
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x3, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rdi
               	movl	$0x2, %esi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%ecx, %ecx
               	movq	0x78(%rsp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	cmpl	$0x3e8, %ecx            # imm = 0x3E8
               	jge	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	nop
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	0x18(%rsp), %rdi
               	movl	$0x2, %esi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	nopw	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rcx
               	movq	0x78(%rsp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jne	<addr>
               	movq	0x78(%rsp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0x34(%rsp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x180, %eax            # imm = 0x180
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x10(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	xorl	%esi, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x98, %rsp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jl	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x34, %rcx
               	addq	%rcx, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	$0x5, %eax
               	addq	$0x98, %rsp
               	retq
