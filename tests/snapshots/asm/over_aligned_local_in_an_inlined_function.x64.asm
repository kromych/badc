
over_aligned_local_in_an_inlined_function.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, (%rsp)
               	movabsq	$0x300000002, %rax      # imm = 0x300000002
               	movq	%rax, 0x8(%rsp)
               	movabsq	$0x500000004, %rax      # imm = 0x500000004
               	movq	%rax, 0x10(%rsp)
               	movabsq	$0x700000006, %rax      # imm = 0x700000006
               	leaq	(%rsp), %rcx
               	movq	%rax, 0x18(%rsp)
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	xorl	%edx, %edx
               	testb	$0x1f, %cl
               	cmoveq	%rdx, %rax
               	movl	0x4(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0xc(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x14(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x1c(%rsp), %ecx
               	addq	%rcx, %rax
               	leaq	(%rsp), %rcx
               	xorl	%edx, %edx
               	movw	$0x100, (%rsp)          # imm = 0x100
               	movb	$0x2, 0x2(%rsp)
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	testb	$0x3f, %cl
               	cmovneq	%rsi, %rdx
               	movsbq	0x1(%rsp), %rcx
               	addq	%rdx, %rcx
               	movsbq	0x2(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x200000001, %rcx      # imm = 0x200000001
               	movq	%rcx, (%rsp)
               	movabsq	$0x400000003, %rcx      # imm = 0x400000003
               	movq	%rcx, 0x8(%rsp)
               	leaq	(%rsp), %rcx
               	movabsq	$0x600000005, %rdx      # imm = 0x600000005
               	movq	%rdx, 0x10(%rsp)
               	movabsq	$0x800000007, %rdx      # imm = 0x800000007
               	movq	%rdx, 0x18(%rsp)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	xorl	%esi, %esi
               	testb	$0x1f, %cl
               	cmoveq	%rsi, %rdx
               	movl	(%rsp), %ecx
               	addq	%rdx, %rcx
               	movl	0x4(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x8(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0xc(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x10(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x14(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x18(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x1c(%rsp), %edx
               	addq	%rdx, %rcx
               	leaq	(%rsp), %rdx
               	movw	$0x101, (%rsp)          # imm = 0x101
               	movb	$0x2, 0x2(%rsp)
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	xorl	%edi, %edi
               	testb	$0x3f, %dl
               	cmoveq	%rdi, %rsi
               	movsbq	(%rsp), %rdx
               	addq	%rsi, %rdx
               	movsbq	0x1(%rsp), %rsi
               	addq	%rsi, %rdx
               	movsbq	0x2(%rsp), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movabsq	$0x300000002, %rcx      # imm = 0x300000002
               	movq	%rcx, (%rsp)
               	movabsq	$0x500000004, %rcx      # imm = 0x500000004
               	movq	%rcx, 0x8(%rsp)
               	movabsq	$0x700000006, %rcx      # imm = 0x700000006
               	leaq	(%rsp), %rdx
               	movq	%rcx, 0x10(%rsp)
               	movabsq	$0x900000008, %rcx      # imm = 0x900000008
               	movq	%rcx, 0x18(%rsp)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	xorl	%esi, %esi
               	testb	$0x1f, %dl
               	cmoveq	%rsi, %rcx
               	movl	(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x4(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x8(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0xc(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x10(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x14(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x18(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x1c(%rsp), %edx
               	addq	%rdx, %rcx
               	leaq	(%rsp), %rdx
               	movw	$0x102, (%rsp)          # imm = 0x102
               	movb	$0x2, 0x2(%rsp)
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	xorl	%edi, %edi
               	testb	$0x3f, %dl
               	cmoveq	%rdi, %rsi
               	movsbq	(%rsp), %rdx
               	addq	%rsi, %rdx
               	movsbq	0x1(%rsp), %rsi
               	addq	%rsi, %rdx
               	movsbq	0x2(%rsp), %rsi
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	0x20(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
