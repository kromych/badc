
utime_sets_times.x64:	file format elf64-x86-64

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
               	subq	$0xb8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0xa0(%rbp), %rax
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
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rbx, %rcx
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
               	leave
               	retq
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0xa0(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0x90(%rbp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	movq	-0x38(%rbp), %rax
               	cmpq	$0x47868c00, %rax       # imm = 0x47868C00
               	jne	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
