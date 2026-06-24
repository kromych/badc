
inc_dec_step_one.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<plus_one>:
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<minus_one>:
               	movq	%rdi, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	retq

<plus_one_l>:
               	movq	%rdi, %rax
               	incq	%rax
               	retq

<minus_neg_one>:
               	movq	%rdi, %rax
               	incq	%rax
               	retq

<count_up>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	retq

<wrap>:
               	movl	%edi, %eax
               	incq	%rax
               	movl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x29, %eax
               	incq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x2b, %eax
               	decq	%rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x2540be3ff, %rax      # imm = 0x2540BE3FF
               	incq	%rax
               	movabsq	$0x2540be400, %r11      # imm = 0x2540BE400
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x29, %eax
               	incq	%rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x29, %eax
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %eax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
