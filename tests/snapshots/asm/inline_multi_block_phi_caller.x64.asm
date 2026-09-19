
inline_multi_block_phi_caller.x64:	file format elf64-x86-64

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
               	movl	$0x1, %ecx
               	leaq	<rip>, %rax
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	movl	$0xaaaaaaab, %r8d       # imm = 0xAAAAAAAB
               	leaq	<rip>, %rdx
               	cmpl	%edi, %eax
               	jae	<addr>
               	movq	%rax, %rsi
               	imulq	%r8, %rsi
               	shrq	$0x21, %rsi
               	leaq	(%rsi,%rsi,2), %r9
               	movq	%rax, %rsi
               	subq	%r9, %rsi
               	cmpl	$0x1, %esi
               	jb	<addr>
               	cmpl	$0x1, %esi
               	je	<addr>
               	movq	%rax, %rsi
               	andq	$0x3, %rsi
               	movl	%ecx, (%rdx,%rsi,4)
               	jmp	<addr>
               	movq	%rax, %rsi
               	andq	$0x3, %rsi
               	movl	(%rdx,%rsi,4), %r9d
               	xorq	%rcx, %r9
               	movl	%r9d, (%rdx,%rsi,4)
               	jmp	<addr>
               	movq	%rax, %rsi
               	andq	$0x3, %rsi
               	movl	(%rdx,%rsi,4), %r9d
               	addq	%rcx, %r9
               	movl	%r9d, (%rdx,%rsi,4)
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	incq	%rax
               	cmpl	%edi, %eax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0xc(%rax), %eax
               	xorq	%rcx, %rax
               	andq	$0x7f, %rax
               	retq
