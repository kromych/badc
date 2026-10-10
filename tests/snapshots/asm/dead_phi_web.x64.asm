
dead_phi_web.x64:	file format elf64-x86-64

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
               	imulq	%rdx, %rcx
               	movq	%rsi, %rax
               	subq	%rcx, %rax
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r13
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movabsq	$-0x24bbe557ef188b23, %r11 # imm = 0xDB441AA810E774DD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x3, %edx
               	movq	%r12, %rsi
               	callq	<addr>
               	movabsq	$0x54f43e32d21c10b0, %r11 # imm = 0x54F43E32D21C10B0
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movabsq	$-0x14a47d7b0ae3e170, %r11 # imm = 0xEB5B8284F51C1E90
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
