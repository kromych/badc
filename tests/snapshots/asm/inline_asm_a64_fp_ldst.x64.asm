
inline_asm_a64_fp_ldst.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movabsq	$0x4045000000000000, %rdx # imm = 0x4045000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x20(%rbp,%riz)
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	movsd	%xmm0, (%rcx,%riz)
               	movsd	%xmm0, -0x18(%rbp,%riz)
               	movq	(%rcx), %rcx
               	movabsq	$0x4045000000000000, %r11 # imm = 0x4045000000000000
               	cmpq	%r11, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsd	-0x18(%rbp,%riz), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
