
inline_into_computed_goto.x64:	file format elf64-x86-64

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

<interp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rdx)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x10(%rdx)
               	movl	$0x1, %ecx
               	movslq	(%rdi), %r8
               	movq	(%rdx,%r8,8), %rdx
               	jmpq	*%rdx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	(%rdi,%rcx,4), %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	andq	$-0x4, %rcx
               	addq	%rcx, %rax
               	leaq	-0x18(%rbp), %r8
               	movslq	%edx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movslq	(%rdi,%rdx,4), %rdx
               	movq	(%r8,%rdx,8), %rdx
               	jmpq	*%rdx
               	addq	%rax, %rax
               	leaq	-0x18(%rbp), %r8
               	movslq	%ecx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movslq	(%rdi,%rdx,4), %rdx
               	movq	(%r8,%rdx,8), %rdx
               	jmpq	*%rdx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x38(%rbp), %rsi
               	movq	$0x67, (%rsi)
               	movq	$0xc9, 0x8(%rsi)
               	movq	$0x12c, 0x10(%rsi)      # imm = 0x12C
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	callq	<addr>
               	cmpq	$0x384, %rax            # imm = 0x384
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
