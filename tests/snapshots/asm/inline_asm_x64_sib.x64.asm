
inline_asm_x64_sib.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	leaq	0x1000(%rax), %rdx
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x5, %ecx
               	movq	(%rbx,%rcx,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1005, %rax           # imm = 0x1005
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movl	$0x5, %ecx
               	movq	0x10(%rbx,%rcx,8), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1007, %rax           # imm = 0x1007
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movl	$0x18, %ecx
               	movq	(%rbx,%rcx), %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1003, %rax           # imm = 0x1003
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movl	$0x2, %ecx
               	movl	(%rbx,%rcx,4), %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x1001, %rax           # imm = 0x1001
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movl	$0x4, %ebx
               	movl	$0xf00d, %ecx           # imm = 0xF00D
               	movq	%rcx, 0x8(%rax,%rbx,2)
               	movq	0x10(%rdx), %rax
               	cmpq	$0xf00d, %rax           # imm = 0xF00D
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rbx
               	movl	$0x3, %ecx
               	leaq	0x8(%rbx,%rcx,8), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leaq	0x20(%rdx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
