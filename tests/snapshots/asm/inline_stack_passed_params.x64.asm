
inline_stack_passed_params.x64:	file format elf64-x86-64

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

<relay_out_of_line>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movswq	%r8w, %r8
               	andq	$0xff, %r9
               	movsbq	0x10(%rbp), %rax
               	movq	0x18(%rbp), %rbx
               	movl	0x20(%rbp), %r12d
               	movq	0x28(%rbp), %r13
               	movq	0x30(%rbp), %r14
               	movl	<rip>, %r15d # <addr>
               	cmpl	%r15d, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	leaq	0x14(%rax), %rdx
               	testl	%eax, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	<rip>, %edi # <addr>
               	cmpl	%edi, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movswq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movzbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	andq	$0xffff, %rbx           # imm = 0xFFFF
               	movzwq	<rip>, %rax # <addr>
               	cmpl	%eax, %ebx
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	%eax, %r12d
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	%eax, %r14d
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movq	$-0x2, %rsi
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movl	$0xf0000003, %ecx       # imm = 0xF0000003
               	movq	$-0x5, %r8
               	movl	$0xfa, %r9d
               	movq	<rip>, %rax # <addr>
               	subq	$0x30, %rsp
               	movq	$-0x7, (%rsp)
               	movabsq	$0x11111111ea60, %r10   # imm = 0x11111111EA60
               	movq	%r10, 0x8(%rsp)
               	movq	$0x9, 0x10(%rsp)
               	movq	$-0xa, 0x18(%rsp)
               	movabsq	$0x123456789abcdef0, %r10 # imm = 0x123456789ABCDEF0
               	movq	%r10, 0x20(%rsp)
               	callq	*%rax
               	addq	$0x30, %rsp
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xf0000003, %eax       # imm = 0xF0000003
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xea60, %eax           # imm = 0xEA60
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$-0xa, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9abcdef0, %eax       # imm = 0x9ABCDEF0
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
