
shm_ipc_segment_round_trip.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	movl	$0x62, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x380, %edx            # imm = 0x380
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testl	%r12d, %r12d
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	cmpq	$-0x1, %r13
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x2, %esi
               	leaq	-0x70(%rbp), %rdx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ebx, %ebx
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	jge	<addr>
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %esi
               	leaq	-0x70(%rbp), %rdx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x5c(%rbp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	xorq	$0x180, %rax            # imm = 0x180
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%r12, %rdi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jl	<addr>
               	xorl	%eax, %eax
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
