
bool_normalize_c99.x64:	file format elf64-x86-64

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

<rti>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<rtd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	$-0x7, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x100, %edi            # imm = 0x100
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	xorl	%ebx, %ebx
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	andq	$0xff, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testb	$-0x1, %al
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x63, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x1, %ebx
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	cmpl	$0x7, %r12d
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x7b, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ebx, %ebx
               	movl	$0x9, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	$-0x3, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %r12d
               	jne	<addr>
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x11, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
