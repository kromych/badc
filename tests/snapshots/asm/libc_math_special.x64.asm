
libc_math_special.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4038000000000000, %rax # imm = 0x4038000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%ebx, %ebx
               	movq	%rbx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rcx # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movq	%rbx, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movsd	%xmm0, 0x18(%rsp)
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movapd	%xmm0, %xmm15
               	movsd	0x18(%rsp), %xmm0
               	addsd	%xmm15, %xmm0
               	movq	%rbx, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x4038000000000000, %rax # imm = 0x4038000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rcx # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	popq	%rbx
               	leave
               	retq
