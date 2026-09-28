
inline_asm_section_symbol_minus_label.x64:	file format elf64-x86-64

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

<record>:
               	leaq	-<rip>, %rax        # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movzwq	0x8(%rcx), %rdx
               	xorq	$0x4d2, %rdx            # imm = 0x4D2
               	testl	%edx, %edx
               	jne	<addr>
               	movzwq	0xa(%rcx), %rdx
               	xorq	$0x7, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movslq	(%rcx), %rdx
               	addq	%rcx, %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movslq	0x4(%rcx), %rax
               	leaq	(%rcx,%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
