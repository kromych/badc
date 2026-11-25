
utime_sets_times.x64:	file format elf64-x86-64

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
               	subq	$0xc0, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rdx
               	movq	%rbx, %rcx
               	movl	$0x200, %esi            # imm = 0x200
               	movq	0x18(%rsp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	addq	$0xc0, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	movq	0x88(%rsp), %rax
               	cmpq	$0x47868c00, %rax       # imm = 0x47868C00
               	jne	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
