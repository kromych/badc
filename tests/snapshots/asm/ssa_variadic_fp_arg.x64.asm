
ssa_variadic_fp_arg.x64:	file format elf64-x86-64

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
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rbx
               	movsd	(%rbx,%riz), %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movabsq	$0x407f900000000000, %r12 # imm = 0x407F900000000000
               	leaq	<rip>, %rdi
               	movq	%r12, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movsd	(%rbx,%riz), %xmm1
               	movb	$0x2, %al
               	callq	<addr>
               	movq	%r12, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movsd	(%rbx,%riz), %xmm0
               	movabsq	$0x407f900000000000, %rax # imm = 0x407F900000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
