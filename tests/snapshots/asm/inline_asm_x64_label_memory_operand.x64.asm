
inline_asm_x64_label_memory_operand.x64:	file format elf64-x86-64

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

<code_numeric>:
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	movl	-<rip>, %eax        # <addr>
               	retq

<code_named>:
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	movl	-<rip>, %eax        # <addr>
               	retq

<section_before>:
               	movl	<rip>, %eax
               	retq

<section_after>:
               	movl	<rip>, %eax
               	retq

<compare>:
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	movl	$0x0, %eax
               	cmpl	$0x2a, -<rip>      # <addr>
               	jne	<addr>
               	movl	$0x2a, %eax
               	retq

<store_load>:
               	movl	$0x2a, <rip>
               	movl	<rip>, %eax
               	retq

<repeated>:
               	xorl	%eax, %eax
               	jmp	<addr>
               	adcl	$0x3000000, %eax        # imm = 0x3000000
               	addl	$0xfffffff6, %eax       # imm = 0xFFFFFFF6
               	jmp	<addr>
               	adcl	$0x3000000, %eax        # imm = 0x3000000
               	addl	$0xfffffff6, %eax       # imm = 0xFFFFFFF6
               	retq

<repeated_twice>:
               	xorl	%eax, %eax
               	addl	$0xe, %eax
               	jmp	<addr>
               	addl	$0xe, %eax
               	jmp	<addr>
               	addl	$0xe, %eax
               	jmp	<addr>
               	retq

<branch_forward>:
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	addl	$0x28, %eax
               	jmp	<addr>
               	retq

<branch_back>:
               	xorl	%eax, %eax
               	jmp	<addr>
               	jmp	<addr>
               	addl	$0x28, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rbx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
