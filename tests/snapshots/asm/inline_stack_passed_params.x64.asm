
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
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	movsbq	0x10(%rbp), %r9
               	movq	0x18(%rbp), %rbx
               	movslq	0x20(%rbp), %r12
               	movq	0x28(%rbp), %r13
               	movq	0x30(%rbp), %r14
               	leaq	<rip>, %r15
               	movslq	(%r15), %r15
               	cmpl	%r15d, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	addq	$0x14, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movswq	(%rcx), %rcx
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	%eax, %r9d
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	%eax, %r12d
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	%eax, %r14d
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	$-0x2, %rsi
               	movabsq	$0x1122334455667788, %rdx # imm = 0x1122334455667788
               	movl	$0xf0000003, %ecx       # imm = 0xF0000003
               	movq	$-0x5, %r8
               	movl	$0xfa, %r9d
               	movq	$-0x7, %rax
               	movabsq	$0x11111111ea60, %rbx   # imm = 0x11111111EA60
               	movl	$0x9, %r12d
               	movq	$-0xa, %r13
               	movabsq	$0x123456789abcdef0, %r14 # imm = 0x123456789ABCDEF0
               	leaq	<rip>, %r15
               	movq	(%r15), %r15
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	subq	$0x30, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	0x30(%rsp), %r10
               	callq	*%r10
               	addq	$0x30, %rsp
               	addq	$0x10, %rsp
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xf0000003, %r11d      # imm = 0xF0000003
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0xea60, %eax           # imm = 0xEA60
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$-0xa, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0x9abcdef0, %r11d      # imm = 0x9ABCDEF0
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
