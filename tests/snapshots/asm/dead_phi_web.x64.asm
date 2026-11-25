
dead_phi_web.x64:	file format elf64-x86-64

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

<quot128>:
               	movq	%rdx, %rcx
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rdi
               	movq	%rdi, %rdx
               	movq	%rsi, %rax
               	divq	%rcx
               	retq
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	jmp	<addr>

<rem128>:
               	movq	%rdx, %rcx
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rdi
               	movq	%rdi, %rdx
               	movq	%rsi, %rax
               	divq	%rcx
               	movq	%rax, %rdx
               	imulq	%rcx, %rdx
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	retq
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rax
               	jmp	<addr>

<rotate_dead>:
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x18(%rsp)
               	movq	%r12, %rdi
               	movq	%rcx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movabsq	$-0x24bbe557ef188b23, %r11 # imm = 0xDB441AA810E774DD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%r12, %rdi
               	movq	%rcx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%rbx, %rsi
               	xorl	%edi, %edi
               	movl	$0x3, %edx
               	callq	<addr>
               	movabsq	$0x54f43e32d21c10b0, %r11 # imm = 0x54F43E32D21C10B0
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%r12, %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%r12, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movabsq	$-0x14a47d7b0ae3e170, %r11 # imm = 0xEB5B8284F51C1E90
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %edi # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
