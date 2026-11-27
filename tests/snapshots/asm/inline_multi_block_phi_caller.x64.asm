
inline_multi_block_phi_caller.x64:	file format elf64-x86-64

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

<main>:
               	movl	$0x1, %ecx
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movl	$0xaaaaaaab, %r8d       # imm = 0xAAAAAAAB
               	leaq	<rip>, %rsi # <addr>
               	jmp	<addr>
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	incq	%rax
               	cmpl	%edi, %eax
               	jae	<addr>
               	movq	%rax, %rdx
               	imulq	%r8, %rdx
               	shrq	$0x21, %rdx
               	leaq	(%rdx,%rdx,2), %r9
               	movq	%rax, %rdx
               	subq	%r9, %rdx
               	cmpl	$0x1, %edx
               	jb	<addr>
               	cmpl	$0x1, %edx
               	je	<addr>
               	movq	%rax, %rdx
               	andq	$0x3, %rdx
               	movl	%ecx, (%rsi,%rdx,4)
               	jmp	<addr>
               	movq	%rax, %rdx
               	andq	$0x3, %rdx
               	movl	(%rsi,%rdx,4), %r9d
               	xorq	%rcx, %r9
               	movl	%r9d, (%rsi,%rdx,4)
               	jmp	<addr>
               	movq	%rax, %rdx
               	andq	$0x3, %rdx
               	movl	(%rsi,%rdx,4), %r9d
               	addq	%rcx, %r9
               	movl	%r9d, (%rsi,%rdx,4)
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	xorq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	xorq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	xorq	%rcx, %rax
               	andq	$0x7f, %rax
               	retq
