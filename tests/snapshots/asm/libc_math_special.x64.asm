
libc_math_special.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<approx>:
               	subsd	%xmm1, %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3eb0c6f7a0b5ed8d, %rax # imm = 0x3EB0C6F7A0B5ED8D
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movabsq	$0x4014000000000000, %rdi # imm = 0x4014000000000000
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x4038000000000000, %rdi # imm = 0x4038000000000000
               	movq	%rdi, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rdi # imm = 0x3FF0000000000000
               	movq	%rdi, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
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
               	movq	%rbx, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x4038000000000000, %rdi # imm = 0x4038000000000000
               	movq	%rdi, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	xorq	%rdi, %rdi
               	movq	%rdi, %xmm1
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
