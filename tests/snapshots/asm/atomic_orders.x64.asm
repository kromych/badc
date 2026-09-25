
atomic_orders.x64:	file format elf64-x86-64

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

<int_ops>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movl	$0xfffeee90, (%rax)     # imm = 0xFFFEEE90
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	cmpl	$0xfffeee90, %edi       # imm = 0xFFFEEE90
               	jne	<addr>
               	movslq	(%rax), %rdi
               	cmpl	$0xfffeee93, %edi       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rax)     # imm = 0xFFFEEE90
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	cmpl	$0xfffeee90, %ecx       # imm = 0xFFFEEE90
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0x9, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0xfffeee90, (%rax)     # imm = 0xFFFEEE90
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	addq	$0x3, %rdi
               	cmpl	$0xfffeee93, %edi       # imm = 0xFFFEEE93
               	jne	<addr>
               	movslq	(%rax), %rdi
               	cmpl	$0xfffeee93, %edi       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rax)     # imm = 0xFFFEEE90
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	orq	%rsi, %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee92, %eax       # imm = 0xFFFEEE92
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0xe, %r9d
               	lock
               	andl	%r9d, (%rcx)
               	lock
               	orl	%edi, (%rcx)
               	lock
               	xorl	%esi, (%rcx)
               	movslq	(%rcx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rcx)     # imm = 0xFFFEEE90
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	$-0x11170, %rsi         # imm = 0xFFFEEE90
               	movl	%esi, (%rcx)
               	movl	$0x9, %edi
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	movl	$0xfffeee90, %r11d      # imm = 0xFFFEEE90
               	movq	%rax, %r8
               	cmpl	%r11d, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movslq	(%rcx), %r8
               	cmpl	$0x9, %r8d
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	%esi, (%rcx)
               	movq	$-0x1116f, %rcx         # imm = 0xFFFEEE91
               	leaq	<rip>, %rsi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rsi)
               	movl	$0xfffeee91, %r11d      # imm = 0xFFFEEE91
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movslq	(%rsi), %rdi
               	cmpl	$0xfffeee90, %edi       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rsi)     # imm = 0xFFFEEE90
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%r8d, (%rsi)
               	movl	$0xfffeee91, %r11d      # imm = 0xFFFEEE91
               	movq	%rax, %r8
               	cmpl	%r11d, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movslq	(%rsi), %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0xfffeee90, %ecx       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, (%rsi)     # imm = 0xFFFEEE90
               	movl	$0xfffeee90, (%rdx)     # imm = 0xFFFEEE90
               	movq	$-0x11170, %rdi         # imm = 0xFFFEEE90
               	movl	$0x9, %r8d
               	movl	%edi, %eax
               	lock
               	cmpxchgl	%r8d, (%rsi)
               	movl	$0xfffeee90, %r11d      # imm = 0xFFFEEE90
               	movq	%rax, %rcx
               	cmpl	%r11d, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movslq	(%rdx), %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	%edi, (%rcx)
               	movq	$-0x1116f, %rsi         # imm = 0xFFFEEE91
               	movl	%esi, (%rdx)
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%r8d, (%rcx)
               	movl	$0xfffeee91, %r11d      # imm = 0xFFFEEE91
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movslq	(%rdx), %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	$-0x11170, %rdx         # imm = 0xFFFEEE90
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	cmpl	$0xfffeee90, %ecx       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	%esi, (%rax)
               	movl	(%rax), %ecx
               	cmpl	$0xfffeee91, %ecx       # imm = 0xFFFEEE91
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	(%rax), %ecx
               	cmpl	$0xfffeee91, %ecx       # imm = 0xFFFEEE91
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rax)
               	leaq	<rip>, %rcx
               	movl	(%rcx), %eax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddl	%edx, (%rcx)
               	cmpl	$0xfffeee90, %edx       # imm = 0xFFFEEE90
               	jne	<addr>
               	movslq	(%rcx), %rdx
               	cmpl	$0xfffeee93, %edx       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	subq	$0x3, %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x6, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	$-0x11170, %rdx         # imm = 0xFFFEEE90
               	movl	%edx, (%rcx)
               	movl	$0x9, %esi
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%esi, (%rcx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x8, %edi
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	$-0x11170, %rdx         # imm = 0xFFFEEE90
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x9, %eax
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x7, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	retq
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<llong_ops>:
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rdx)
               	movl	$0x6, %esi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rdx)
               	movl	$0x6, %esi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rdx)
               	movl	$0x6, %esi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rdx)
               	movl	$0x6, %esi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rdx)
               	movl	$0x6, %esi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rax)
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rdx)
               	movl	$0x6, %esi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, (%rdx)
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	(%rdx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdx)
               	movl	$0x9, %edi
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	%rsi, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movq	(%rdx), %r8
               	cmpq	$0x9, %r8
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdx)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rsi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rdi
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rsi)
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, (%rsi)
               	movq	%rdi, (%rcx)
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi
               	movq	%rdx, (%rdi)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, (%rcx)
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	(%rdi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, (%rdi)
               	leaq	<rip>, %rdi
               	movl	$0x9, %r8d
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rsi, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movq	(%rdi), %r8
               	cmpq	$0x9, %r8
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, (%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdi, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rdx, (%rsi)
               	movq	%rdx, (%rcx)
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	(%rsi), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rsi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rsi, (%rcx)
               	leaq	<rip>, %rdi
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rsi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	(%rdi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movq	(%rsi), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%r8, (%rsi)
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rsi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	(%rsi), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rsi
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rdi
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rsi)
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	%rdi, (%rdx)
               	movq	%rdi, (%rcx)
               	movq	%rdi, %rax
               	lock
               	cmpxchgq	%r8, (%rdx)
               	cmpq	%rdi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rdx), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdi, (%rcx)
               	movl	$0x9, %r8d
               	movq	%rdi, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rsi)
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movabsq	$-0x12a05f1ff, %rsi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rsi
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movq	%rdx, (%rcx)
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, (%rcx)
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rdi
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, (%rsi)
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	%rdi, (%rdx)
               	movq	%rdi, (%rcx)
               	movq	%rdi, %rax
               	lock
               	cmpxchgq	%r8, (%rdx)
               	cmpq	%rdi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	(%rdx), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdi, (%rcx)
               	movl	$0x9, %r8d
               	movq	%rdi, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, (%rsi)
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, (%rdx)
               	movabsq	$-0x12a05f1ff, %rsi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, (%rdx)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rsi
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rsi)
               	movq	%rdx, (%rcx)
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rdx, (%rsi)
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, (%rcx)
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, (%rsi)
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	movq	(%rax), %rdx
               	movabsq	$-0x12a05f1ff, %r11     # imm = 0xFFFFFFFED5FA0E01
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	(%rax), %rdx
               	movabsq	$-0x12a05f1ff, %r11     # imm = 0xFFFFFFFED5FA0E01
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, %r10
               	xchgq	%r10, (%rax)
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	(%rcx), %rdx
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0x3, %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x6, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rcx)
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x8, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x9, %eax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	je	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x7, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	retq
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<schar_ops>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movb	$-0x3, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	movsbq	%dil, %rdi
               	cmpl	$-0x3, %edi
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rax)
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movsbq	%cl, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$-0x6, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x3, (%rcx)
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rcx)
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x3, (%rcx)
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rcx)
               	movl	$0x9, %eax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rax
               	movb	$-0x3, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	movsbq	%dil, %rdi
               	addq	$0x3, %rdi
               	movsbq	%dil, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rax)
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movsbq	%cl, %rax
               	subq	$0x3, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x6, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$-0x6, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x3, (%rcx)
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	andq	%rsi, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rcx)
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	orq	%rsi, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x3, (%rcx)
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	xorq	%rdi, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rcx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movsbq	(%rcx), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x3, (%rcx)
               	movl	$0xe, %r9d
               	lock
               	andb	%r9b, (%rcx)
               	lock
               	orb	%dil, (%rcx)
               	lock
               	xorb	%sil, (%rcx)
               	movsbq	(%rcx), %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rcx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	$-0x3, %rsi
               	movb	%sil, (%rcx)
               	movl	$0x9, %edi
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0xfd, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movsbq	(%rcx), %r8
               	cmpl	$0x9, %r8d
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	%sil, (%rcx)
               	movq	$-0x2, %rcx
               	leaq	<rip>, %rsi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rsi)
               	cmpl	$0xfe, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movsbq	(%rsi), %rdi
               	cmpl	$-0x3, %edi
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rsi)
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%r8b, (%rsi)
               	cmpl	$0xfe, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movsbq	(%rsi), %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	%cl, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, (%rsi)
               	movb	$-0x3, (%rdx)
               	movq	$-0x3, %rdi
               	movl	$0x9, %r8d
               	movzbq	%dil, %rax
               	lock
               	cmpxchgb	%r8b, (%rsi)
               	cmpl	$0xfd, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	(%rdx), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	%dil, (%rcx)
               	movq	$-0x2, %rsi
               	movb	%sil, (%rdx)
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%r8b, (%rcx)
               	cmpl	$0xfe, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	(%rdx), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	$-0x3, %rdx
               	movb	%dl, (%rcx)
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x3, %ecx
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	%sil, (%rax)
               	movzbq	(%rax), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movzbq	(%rax), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddb	%dl, (%rcx)
               	movsbq	%dl, %rdx
               	cmpl	$-0x3, %edx
               	jne	<addr>
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	negq	%rax
               	lock
               	xaddb	%al, (%rcx)
               	movsbq	%al, %rax
               	subq	$0x3, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x6, %edx
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	$-0x3, %rdx
               	movb	%dl, (%rcx)
               	movl	$0x9, %esi
               	movzbq	%dl, %rax
               	lock
               	cmpxchgb	%sil, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x8, %edi
               	movzbq	%dl, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	$-0x3, %rdx
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dl, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x9, %eax
               	movzbq	%al, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x7, %eax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	retq
               	movb	%al, (%rdx)
               	jmp	<addr>
               	movb	%al, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<uchar_ops>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movb	$-0x6, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	andq	$0xff, %rdi
               	cmpl	$0xfa, %edi
               	jne	<addr>
               	movzbq	(%rax), %rdi
               	cmpl	$0xfd, %edi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rax)
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0xf7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x6, (%rcx)
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rcx)
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0xfe, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x6, (%rcx)
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rcx)
               	movl	$0x9, %eax
               	xchgb	%al, (%rcx)
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rax
               	movb	$-0x6, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	andq	$0xff, %rdi
               	addq	$0x3, %rdi
               	andq	$0xff, %rdi
               	cmpl	$0xfd, %edi
               	jne	<addr>
               	movzbq	(%rax), %rdi
               	cmpl	$0xfd, %edi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rax)
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	subq	$0x3, %rax
               	andq	$0xff, %rax
               	cmpl	$0xf7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0xf7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x6, (%rcx)
               	movl	$0x6, %esi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	andq	%rsi, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rcx)
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	orq	%rsi, %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0xfe, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x6, (%rcx)
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	xorq	%rdi, %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rcx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movzbq	(%rcx), %rax
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	$-0x6, (%rcx)
               	movl	$0xe, %r9d
               	lock
               	andb	%r9b, (%rcx)
               	lock
               	orb	%dil, (%rcx)
               	lock
               	xorb	%sil, (%rcx)
               	movzbq	(%rcx), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rcx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0xfa, %esi
               	movb	%sil, (%rcx)
               	movl	$0x9, %edi
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0xfa, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movzbq	(%rcx), %r8
               	cmpl	$0x9, %r8d
               	jne	<addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	%sil, (%rcx)
               	movl	$0xfb, %ecx
               	leaq	<rip>, %rsi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rsi)
               	cmpl	$0xfb, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movzbq	(%rsi), %rdi
               	cmpl	$0xfa, %edi
               	jne	<addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rsi)
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%r8b, (%rsi)
               	cmpl	$0xfb, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	(%rsi), %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	cmpl	$0xfa, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, (%rsi)
               	movb	$-0x6, (%rdx)
               	movl	$0xfa, %edi
               	movl	$0x9, %r8d
               	movzbq	%dil, %rax
               	lock
               	cmpxchgb	%r8b, (%rsi)
               	cmpl	$0xfa, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	(%rdx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movb	%dil, (%rcx)
               	movl	$0xfb, %esi
               	movb	%sil, (%rdx)
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%r8b, (%rcx)
               	cmpl	$0xfb, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	(%rdx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0xfa, %edx
               	movb	%dl, (%rcx)
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	cmpl	$0xfa, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	%sil, (%rax)
               	movzbq	(%rax), %rcx
               	cmpl	$0xfb, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movzbq	(%rax), %rcx
               	cmpl	$0xfb, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddb	%dl, (%rcx)
               	andq	$0xff, %rdx
               	cmpl	$0xfa, %edx
               	jne	<addr>
               	movzbq	(%rcx), %rdx
               	cmpl	$0xfd, %edx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	negq	%rax
               	lock
               	xaddb	%al, (%rcx)
               	andq	$0xff, %rax
               	subq	$0x3, %rax
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x6, %edx
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfa, %edx
               	movb	%dl, (%rcx)
               	movl	$0x9, %esi
               	movzbq	%dl, %rax
               	lock
               	cmpxchgb	%sil, (%rcx)
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x8, %edi
               	movzbq	%dl, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfa, %edx
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dl, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x9, %eax
               	movzbq	%al, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x7, %eax
               	xchgb	%al, (%rcx)
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	retq
               	movb	%al, (%rdx)
               	jmp	<addr>
               	movb	%al, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<short_ops>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movw	$0xfed4, (%rax)         # imm = 0xFED4
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddw	%di, (%rax)
               	movswq	%di, %rdi
               	cmpl	$0xfffffed4, %edi       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rax), %rdi
               	cmpl	$0xfffffed7, %edi       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rax)         # imm = 0xFED4
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movswq	%cx, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0x9, %eax
               	xchgw	%ax, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rax
               	movw	$0xfed4, (%rax)         # imm = 0xFED4
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddw	%di, (%rax)
               	movswq	%di, %rdi
               	addq	$0x3, %rdi
               	movswq	%di, %rdi
               	cmpl	$0xfffffed7, %edi       # imm = 0xFFFFFED7
               	jne	<addr>
               	movswq	(%rax), %rdi
               	cmpl	$0xfffffed7, %edi       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rax)         # imm = 0xFED4
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movswq	%cx, %rax
               	subq	$0x3, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	andq	%rsi, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	orq	%rsi, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	xorq	%rdi, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0xe, %r9d
               	lock
               	andw	%r9w, (%rcx)
               	lock
               	orw	%di, (%rcx)
               	lock
               	xorw	%si, (%rcx)
               	movswq	(%rcx), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rcx)         # imm = 0xFED4
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgw	%r10w, (%rcx)
               	leaq	<rip>, %rcx
               	movswq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	$-0x12c, %rsi           # imm = 0xFED4
               	movw	%si, (%rcx)
               	movl	$0x9, %edi
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0xfed4, %eax           # imm = 0xFED4
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movswq	(%rcx), %r8
               	cmpl	$0x9, %r8d
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	%si, (%rcx)
               	movq	$-0x12b, %rcx           # imm = 0xFED5
               	leaq	<rip>, %rsi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rsi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movswq	(%rsi), %rdi
               	cmpl	$0xfffffed4, %edi       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rsi)         # imm = 0xFED4
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%r8w, (%rsi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movswq	(%rsi), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	%cx, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, (%rsi)         # imm = 0xFED4
               	movw	$0xfed4, (%rdx)         # imm = 0xFED4
               	movq	$-0x12c, %rdi           # imm = 0xFED4
               	movl	$0x9, %r8d
               	movzwl	%di, %eax
               	lock
               	cmpxchgw	%r8w, (%rsi)
               	cmpl	$0xfed4, %eax           # imm = 0xFED4
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	(%rdx), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	%di, (%rcx)
               	movq	$-0x12b, %rsi           # imm = 0xFED5
               	movw	%si, (%rdx)
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%r8w, (%rcx)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rdx), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	$-0x12c, %rdx           # imm = 0xFED4
               	movw	%dx, (%rcx)
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffed4, %ecx       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	%si, (%rax)
               	movzwq	(%rax), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffed5, %ecx       # imm = 0xFFFFFED5
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movzwq	(%rax), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffed5, %ecx       # imm = 0xFFFFFED5
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	%rdx, %r10
               	xchgw	%r10w, (%rax)
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddw	%dx, (%rcx)
               	movswq	%dx, %rdx
               	cmpl	$0xfffffed4, %edx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rcx), %rdx
               	cmpl	$0xfffffed7, %edx       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	negq	%rax
               	lock
               	xaddw	%ax, (%rcx)
               	movswq	%ax, %rax
               	subq	$0x3, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x6, %edx
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	$-0x12c, %rdx           # imm = 0xFED4
               	movw	%dx, (%rcx)
               	movl	$0x9, %esi
               	movzwl	%dx, %eax
               	lock
               	cmpxchgw	%si, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x8, %edi
               	movzwl	%dx, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	$-0x12c, %rdx           # imm = 0xFED4
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%dx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x9, %eax
               	movzwl	%ax, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movswq	(%rcx), %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x7, %eax
               	xchgw	%ax, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movw	%ax, (%rcx)
               	cmpw	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	retq
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<ushort_ops>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movw	$0xfde8, (%rax)         # imm = 0xFDE8
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddw	%di, (%rax)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	$0xfde8, %edi           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	(%rax), %rdi
               	cmpl	$0xfdeb, %edi           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rax)         # imm = 0xFDE8
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	cmpw	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0x9, %eax
               	xchgw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rax
               	movw	$0xfde8, (%rax)         # imm = 0xFDE8
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddw	%di, (%rax)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	addq	$0x3, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	$0xfdeb, %edi           # imm = 0xFDEB
               	jne	<addr>
               	movzwq	(%rax), %rdi
               	cmpl	$0xfdeb, %edi           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rax)         # imm = 0xFDE8
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	subq	$0x3, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0x6, %esi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpw	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	orq	%rsi, %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	%rdi, %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movzwq	(%rcx), %rax
               	cmpl	$0xfdea, %eax           # imm = 0xFDEA
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0xe, %r9d
               	lock
               	andw	%r9w, (%rcx)
               	lock
               	orw	%di, (%rcx)
               	lock
               	xorw	%si, (%rcx)
               	movzwq	(%rcx), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rcx)         # imm = 0xFDE8
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgw	%r10w, (%rcx)
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0xfde8, %esi           # imm = 0xFDE8
               	movw	%si, (%rcx)
               	movl	$0x9, %edi
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	%esi, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movzwq	(%rcx), %r8
               	cmpl	$0x9, %r8d
               	jne	<addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	%si, (%rcx)
               	movl	$0xfde9, %ecx           # imm = 0xFDE9
               	leaq	<rip>, %rsi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movzwq	(%rsi), %rdi
               	cmpl	$0xfde8, %edi           # imm = 0xFDE8
               	jne	<addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rsi)         # imm = 0xFDE8
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%r8w, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzwq	(%rsi), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	cmpl	$0xfde8, %ecx           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, (%rsi)         # imm = 0xFDE8
               	movw	$0xfde8, (%rdx)         # imm = 0xFDE8
               	movl	$0xfde8, %edi           # imm = 0xFDE8
               	movl	$0x9, %r8d
               	movzwl	%di, %eax
               	lock
               	cmpxchgw	%r8w, (%rsi)
               	cmpl	%edi, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	(%rdx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movw	%di, (%rcx)
               	movl	$0xfde9, %esi           # imm = 0xFDE9
               	movw	%si, (%rdx)
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%r8w, (%rcx)
               	cmpl	%esi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	(%rdx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0xfde8, %edx           # imm = 0xFDE8
               	movw	%dx, (%rcx)
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rcx
               	cmpl	$0xfde8, %ecx           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	%si, (%rax)
               	movzwq	(%rax), %rcx
               	cmpl	$0xfde9, %ecx           # imm = 0xFDE9
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movzwq	(%rax), %rcx
               	cmpl	$0xfde9, %ecx           # imm = 0xFDE9
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movq	%rdx, %r10
               	xchgw	%r10w, (%rax)
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddw	%dx, (%rcx)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	$0xfde8, %edx           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	(%rcx), %rdx
               	cmpl	$0xfdeb, %edx           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	negq	%rax
               	lock
               	xaddw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	subq	$0x3, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x6, %edx
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfde8, %edx           # imm = 0xFDE8
               	movw	%dx, (%rcx)
               	movl	$0x9, %esi
               	movzwl	%dx, %eax
               	lock
               	cmpxchgw	%si, (%rcx)
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x8, %edi
               	movzwl	%dx, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xfde8, %edx           # imm = 0xFDE8
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%dx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x9, %eax
               	movzwl	%ax, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x7, %eax
               	xchgw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movw	%ax, (%rcx)
               	cmpw	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	retq
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<uint_ops>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movl	$0xee6b2800, (%rax)     # imm = 0xEE6B2800
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %edi
               	jne	<addr>
               	movl	(%rax), %edi
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edi
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rax)     # imm = 0xEE6B2800
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rcx, %rax
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xee6b27fd, %r11d      # imm = 0xEE6B27FD
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0x9, %eax
               	xchgl	%eax, (%rcx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0xee6b2800, (%rax)     # imm = 0xEE6B2800
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	addq	$0x3, %rdi
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edi
               	jne	<addr>
               	movl	(%rax), %edi
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edi
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rax)     # imm = 0xEE6B2800
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movl	$0xee6b27fd, %r11d      # imm = 0xEE6B27FD
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xee6b27fd, %r11d      # imm = 0xEE6B27FD
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0x6, %esi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	(%rcx), %eax
               	movl	$0xee6b2802, %r11d      # imm = 0xEE6B2802
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0xe, %r9d
               	lock
               	andl	%r9d, (%rcx)
               	lock
               	orl	%edi, (%rcx)
               	lock
               	xorl	%esi, (%rcx)
               	movl	(%rcx), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rcx)     # imm = 0xEE6B2800
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	leaq	<rip>, %rcx
               	movl	(%rcx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, %esi       # imm = 0xEE6B2800
               	movl	%esi, (%rcx)
               	movl	$0x9, %edi
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	%esi, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movl	(%rcx), %r8d
               	cmpl	$0x9, %r8d
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	%esi, (%rcx)
               	movl	$0xee6b2801, %ecx       # imm = 0xEE6B2801
               	leaq	<rip>, %rsi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movl	(%rsi), %edi
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %edi
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rsi)     # imm = 0xEE6B2800
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%r8d, (%rsi)
               	cmpl	%ecx, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	(%rsi), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rcx, %rax
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, (%rsi)     # imm = 0xEE6B2800
               	movl	$0xee6b2800, (%rdx)     # imm = 0xEE6B2800
               	movl	$0xee6b2800, %edi       # imm = 0xEE6B2800
               	movl	$0x9, %r8d
               	movl	%edi, %eax
               	lock
               	cmpxchgl	%r8d, (%rsi)
               	cmpl	%edi, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	(%rdx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	%edi, (%rcx)
               	movl	$0xee6b2801, %esi       # imm = 0xEE6B2801
               	movl	%esi, (%rdx)
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%r8d, (%rcx)
               	cmpl	%esi, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	(%rdx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	%esi, (%rax)
               	movl	(%rax), %ecx
               	movl	$0xee6b2801, %r11d      # imm = 0xEE6B2801
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	(%rax), %ecx
               	movl	$0xee6b2801, %r11d      # imm = 0xEE6B2801
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rax)
               	leaq	<rip>, %rcx
               	movl	(%rcx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddl	%edx, (%rcx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	(%rcx), %edx
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	subq	$0x3, %rax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x6, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	movl	%edx, (%rcx)
               	movl	$0x9, %esi
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%esi, (%rcx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x8, %edi
               	movl	%edx, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x9, %eax
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x7, %eax
               	xchgl	%eax, (%rcx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	retq
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<ullong_ops>:
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, (%rax)
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x7000000000000000, %rsi # imm = 0x9000000000000000
               	movq	%rsi, (%rcx)
               	movl	$0x6, %edi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rsi, (%rcx)
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x7000000000000000, %rsi # imm = 0x9000000000000000
               	movq	%rsi, (%rcx)
               	movl	$0x6, %edi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rsi, (%rcx)
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rax
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	(%rax), %rdi
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, (%rax)
               	movq	%rsi, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x7000000000000000, %rdi # imm = 0x9000000000000000
               	movq	%rdi, (%rcx)
               	movl	$0x6, %esi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	andq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdi, (%rcx)
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rsi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	orq	%rsi, %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x7000000000000000, %rsi # imm = 0x9000000000000000
               	movq	%rsi, (%rcx)
               	movl	$0x6, %edi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rsi, (%rcx)
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	(%rcx), %rax
               	movabsq	$-0x6ffffffffffffffe, %r11 # imm = 0x9000000000000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x7000000000000000, %r8 # imm = 0x9000000000000000
               	movq	%r8, (%rcx)
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rcx)
               	lock
               	orq	%rdi, (%rcx)
               	lock
               	xorq	%rsi, (%rcx)
               	movq	(%rcx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%r8, (%rcx)
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rsi # imm = 0x9000000000000000
               	movq	%rsi, (%rcx)
               	movl	$0x9, %edi
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	%rsi, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%r8, %r8
               	je	<addr>
               	movq	(%rcx), %r8
               	cmpq	$0x9, %r8
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rsi, (%rcx)
               	movabsq	$-0x6fffffffffffffff, %rcx # imm = 0x9000000000000001
               	leaq	<rip>, %rsi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rsi), %rdi
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rdi # imm = 0x9000000000000000
               	movq	%rdi, (%rsi)
               	leaq	<rip>, %rsi
               	movl	$0x9, %r8d
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rcx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	(%rsi), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdi, (%rsi)
               	movq	%rdi, (%rdx)
               	movabsq	$-0x7000000000000000, %rdi # imm = 0x9000000000000000
               	movl	$0x9, %r8d
               	movq	%rdi, %rax
               	lock
               	cmpxchgq	%r8, (%rsi)
               	cmpq	%rdi, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rdi, (%rcx)
               	movabsq	$-0x6fffffffffffffff, %rsi # imm = 0x9000000000000001
               	movq	%rsi, (%rdx)
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rcx)
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rsi, (%rax)
               	movq	(%rax), %rcx
               	movabsq	$-0x6fffffffffffffff, %r11 # imm = 0x9000000000000001
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	(%rax), %rcx
               	movabsq	$-0x6fffffffffffffff, %r11 # imm = 0x9000000000000001
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, %r10
               	xchgq	%r10, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	(%rcx), %rdx
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0x3, %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x6, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, (%rcx)
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x8, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x9, %eax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	je	<addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x7, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	retq
               	movq	%rax, (%rdx)
               	jmp	<addr>
               	movq	%rax, (%rdx)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<other_ops>:
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rsi)
               	leaq	0x4(%rcx), %rdi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	movq	%rax, %rdx
               	cmpq	%rcx, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsi), %rax
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0xa6, %eax
               	retq
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rcx, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0xa7, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, %rdx
               	xchgq	%rdx, (%rcx)
               	leaq	0x4(%rax), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xa8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0xa, %eax
               	movl	%eax, (%rcx)
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0xab, %eax
               	retq
               	movl	$0x3, %eax
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0xac, %eax
               	retq
               	movl	$0x40, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0xad, %eax
               	retq
               	movl	$0x48, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x4c, %eax
               	je	<addr>
               	movl	$0xae, %eax
               	retq
               	movl	$0x1, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x48, %eax
               	je	<addr>
               	movl	$0xaf, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	$-0x1, %rcx
               	movq	%rcx, %rax
               	xchgl	%eax, (%rdx)
               	cmpl	$0x49, %eax
               	je	<addr>
               	movl	$0xb0, %eax
               	retq
               	movl	$0x4, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rdx)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	(%rdx), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb2, %eax
               	retq
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xb3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rcx)
               	movl	$0x7, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rcx)
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xb8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x1, %edx
               	movq	%rdx, %rax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xbc, %eax
               	retq
               	movq	%rdx, %rax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xbd, %eax
               	retq
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	xchgb	%dl, (%rcx)
               	movsbq	%dl, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xbf, %eax
               	retq
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	xchgb	%sil, (%rcx)
               	testb	$-0x1, %sil
               	jne	<addr>
               	xchgb	%dl, (%rcx)
               	testb	$-0x1, %dl
               	jne	<addr>
               	movl	$0xc1, %eax
               	retq
               	movb	%al, (%rcx)
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movl	$0xc3, %eax
               	retq
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
